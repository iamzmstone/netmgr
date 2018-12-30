require 'zabbixapi'

class ZabbixAgent
  def initialize(url, user, passwd)
    @zbx = ZabbixApi.connect(
      url: url,
      user: user,
      password: passwd
    )
  end

  def create_hostgroup(group_name)
    @zbx.hostgroups.create(name: group_name) unless @zbx.hostgroups.get_id(name: group_name)
    @zbx.hostgroups.get_id(name: group_name)
  end

  def delete_host(host)
    @zbx.hosts.delete(@zbx.hosts.get_id(host: host.ip)) if @zbx.hosts.get_id(host: host.ip)
  end

  def create_host(host, group_id)
    delete_host(host)
    @zbx.hosts.create(
      host: host.ip,
      name: host.name,
      interfaces: [ {
        type: 2,
        main: 1,
        ip: host.ip,
        dns: '',
        port: 161,
        useip: 1
      } ],
      groups: [ groupid: group_id ]
    )

    host_id = @zbx.hosts.get_id(host: host.ip)
    return nil unless host_id

    interface_id = query_interface_id(host_id)
    @zbx.applications.create(name: 'switch interface', hostid: host_id)
    app_id = @zbx.applications.get_id(name: 'switch interface', hostid: host_id)
    @zbx.usermacros.create(macro: '{$SNMP_COMMUNITY}', value: ENV['snmp_read_community'], hostid: host_id)

    return { id: host_id, interface_id: interface_id, app_id: app_id }
  end

  def host_info(host)
    host_id = @zbx.hosts.get_id(host: host.ip)
    interface_id = query_interface_id(host_id)
    app_id = @zbx.applications.get_id(name: 'switch interface', hostid: host_id)

    return { id: host_id, interface_id: interface_id, app_id: app_id }
  end

  def query_interface_id(host_id)
    @zbx.query(method: 'hostinterface.get',
              params: { hostids: host_id, templated: true, output: 'extend' }).first['interfaceid']
  end

  def create_screen(host)
    # create screen
    @zbx.screens.get_or_create_for_host(
      screen_name: "screen for #{host.name}",
      graphids: zbx.graphs.get_ids_by_host(host: host.ip),
      hsize: 2
    )
  end

  def delete_port_conf(host, p)
    zbx = @zbx
    mib = p.mib_info

    zbx.items.delete(zbx.items.get_id(name: "#{mib.port_desc} incomming traffic", hostid: host[:id]))
    zbx.items.delete(zbx.items.get_id(name: "#{mib.port_desc} outgoing traffic", hostid: host[:id]))
    zbx.items.delete(zbx.items.get_id(name: "#{mib.port_desc} operational status", hostid: host[:id]))
  end

  def create_port_conf(host, p)
    zbx = @zbx
    s = p.switch
    mib = p.mib_info

    # create items
    zbx.items.create(
      name: "#{mib.port_desc} incomming traffic",
      description: "Incomming traffic on interface #{s.name}:#{mib.port_desc}",
      interfaceid: host[:interface_id],
      key_: "ifInOctets[#{mib.port_desc}]",
      units: 'bps',
      type: 4,
      value_type: 3,
      delta: 1,
      multiplier: 1,
      formula: 8,
      snmp_community: '{$SNMP_COMMUNITY}',
      snmp_oid: "IF-MIB::ifHCInOctets.#{mib.if_nbr}",
      delay: ENV['sw_traffic_check_delay'] || 300,
      hostid: host[:id],
      applications: [host[:app_id]]
    )

    zbx.items.create(
      name: "#{mib.port_desc} outgoing traffic",
      description: "outgoing traffic on interface #{s.name}:#{mib.port_desc}",
      interfaceid: host[:interface_id],
      key_: "ifOutOctets[#{mib.port_desc}]",
      units: 'bps',
      type: 4,
      value_type: 3,
      delta: 1,
      multiplier: 1,
      formula: 8,
      snmp_community: '{$SNMP_COMMUNITY}',
      snmp_oid: "IF-MIB::ifHCOutOctets.#{mib.if_nbr}",
      delay:  ENV['sw_traffic_check_delay'] || 300,
      hostid: host[:id],
      applications: [host[:app_id]]
    )

    zbx.items.create(
      name: "#{mib.port_desc} operational status",
      description: "Operational status of #{s.name}:#{mib.port_desc}",
      interfaceid: host[:interface_id],
      key_: "ifOperStatus[#{mib.port_desc}]",
      type: 4,
      value_type: 3,
      valuemapid: 8,
      snmp_community: '{$SNMP_COMMUNITY}',
      snmp_oid: "IF-MIB::ifOperStatus.#{mib.if_nbr}",
      delay:  ENV['sw_status_check_delay'] || 300,
      hostid: host[:id],
      applications: [host[:app_id]]
    )

    # create graph
    gitems = []
    gitems << { itemid: zbx.items.get_id(name: "#{mib.port_desc} incomming traffic",
                                         hostid: host[:id]), color: '00AA00' }
    gitems << { itemid: zbx.items.get_id(name: "#{mib.port_desc} outgoing traffic",
                                         hostid: host[:id]), color: '3333FF' }

    zbx.graphs.create(gitems: gitems, name: "Traffic flow of interface #{mib.port_desc}:#{p.remark}")

    # create triggers
    zbx.triggers.create(
      # description: "#{s.name}:#{s.ip}:#{mib.port_desc}:#{p.remark} incoming traffic is too high",
      description: "#{s.name}:#{s.ip}:#{mib.port_desc}:#{p.remark} 入端口流量已达到85%",
      expression: "{#{s.ip}:ifInOctets[#{mib.port_desc}].last(#3)}/(#{p.speed || 1000}*1024*1024)>0.85",
      comments: "#{s.name}:#{mib.port_desc} incoming traffic is too high(over 85%)",
      priority: 4,
      status: 0,
      type: 0,
      recovery_mode: 1,
      recovery_expression: "{#{s.ip}:ifInOctets[#{mib.port_desc}].last(#3)}/(#{p.speed || 1000}*1024*1024)<0.75",
      tags: [ { tag: 'inc_traffic', value: "#{s.name}:#{mib.port_desc}" } ]
    )

    zbx.triggers.create(
      # description: "#{s.name}:#{s.ip}:#{mib.port_desc}:#{p.remark} outgoing traffic is too high",
      description: "#{s.name}:#{s.ip}:#{mib.port_desc}:#{p.remark} 出端口流量达到85%",
      expression: "{#{s.ip}:ifOutOctets[#{mib.port_desc}].last(#3)}/(#{p.speed || 1000}*1024*1024)>0.85",
      comments: "#{s.name}:#{mib.port_desc} outgoing traffic is too high(over 85%)",
      priority: 4,
      status: 0,
      type: 0,
      recovery_mode: 1,
      recovery_expression: "{#{s.ip}:ifOutOctets[#{mib.port_desc}].last(#3)}/(#{p.speed || 1000}*1024*1024)<0.75",
      tags: [ { tag: 'out_traffic', value: "#{s.name}:#{mib.port_desc}" } ]
    )

    zbx.triggers.create(
      # description: "#{s.name}:#{s.ip}:#{mib.port_desc}:#{p.remark} is down",
      description: "#{s.name}:#{s.ip}:#{mib.port_desc}:#{p.remark} 链路断!!!",
      expression: "{#{s.ip}:ifOperStatus[#{mib.port_desc}].last(#3)}=2",
      comments: "Interface #{s.name}:#{mib.port_desc} is down",
      priority: 5,
      status: 0,
      type: 0,
      recovery_mode: 1,
      recovery_expression: "{#{s.ip}:ifOperStatus[#{mib.port_desc}].last(#3)}=1",
      tags: [ { tag: 'oper_status', value: "#{s.name}:#{mib.port_desc}" } ]
    )
  end
end
