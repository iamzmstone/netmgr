class Switch < ApplicationRecord
  has_many :ports, dependent: :destroy
  has_many :vlans, dependent: :destroy
  has_many :mib_ports, dependent: :destroy

  # after_create :create_zabbix_host
  # after_create :create_mib_info
  # after_destroy :delete_zabbix_host

  private
  def create_mib_info
    SNMP::Manager.open(host: self.ip, community: ENV['snmp_read_community'] || 'public') do |mgr|
      if_count = mgr.get('ifNumber.0').varbind_list.first.value.to_i
      (1..if_count).to_a.each do |if_id|
        port_desc = mgr.get("ifDescr.#{if_id}").varbind_list.first.value.to_s
        self.mib_ports.where(if_nbr: if_id).first_or_create(port_desc: port_desc)
      end
    end
  end

  def create_zabbix_host
    zbx_agent = ZabbixAgent.new(ENV['zabbix_front_url'], ENV['zabbix_user'], ENV['zabbix_password'])
    group_id = zbx_agent.create_hostgroup(ENV['hostgroup_name'])
    zbx_agent.create_host(self, group_id)
  end

  def delete_zabbix_host
    zbx_agent = ZabbixAgent.new(ENV['zabbix_front_url'], ENV['zabbix_user'], ENV['zabbix_password'])
    zbx_agent.delete_host(self)
  end
end
