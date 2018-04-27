require 'snmp'
require 'utils/zabbix_agent'

namespace :snmp do
  desc 'get interface snmp info of all swiches'
  task(interface: :environment) do
    Switch.all.each do |s|
      puts "#{s.name} ..."
      SNMP::Manager.open(host: s.ip, community: ENV['snmp_read_community'] || 'public') do |mgr|
        if_count = mgr.get('ifNumber.0').varbind_list.first.value.to_i
        (1..if_count).to_a.each do |if_id|
          port_desc = mgr.get("ifDescr.#{if_id}").varbind_list.first.value.to_s
          s.mib_ports.where(if_nbr: if_id).first_or_create(port_desc: port_desc)
        end
      end
    end
  end

  desc 'config host, operation/traffic items, graphs, triggers on Zabbix front for all important interfaces of switch'
  task(config_zabbix: :environment) do
    zbx_agent = ZabbixAgent.new(ENV['zabbix_front_url'], ENV['zabbix_user'], ENV['zabbix_password'])
    group_id = zbx_agent.create_hostgroup(ENV['hostgroup_name'])

    Switch.all.each do |s|
      puts "#{s.name} ..."

      host = zbx_agent.create_host(s, group_id)
      unless host
        puts "Error: create zabbox configuration host [#{s.name}] failed"
        return
      end

      s.ports.each do |p|
        puts "\t#{p.port} ..."
        zbx_agent.create_port_conf(host, p)
      end
    end
  end

  desc 'generate prometheus config files for switch ports'
  task(prometheus_config: :environment) do
    ports = []
    Port.all.each do |p|
      ports << { switch: p.switch.name, ip: p.switch.ip, name: p.mib_info.port_desc, remark: p.remark, speed: p.speed, if_index: p.mib_info.if_nbr }
    end

    puts ERB.new(File.read('/app/views/template/prom_alert_rules.erb')).result
    puts ERB.new(File.read('/app/views/template/prom_recording_rules.erb')).result
  end
end

