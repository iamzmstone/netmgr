class Port < ApplicationRecord
  belongs_to :switch
  # after_create :create_zabbix_config

  def in_usgs
    in_usg.present? ? in_usg.split(',') : []
  end

  def in_usgs=(in_usgs)
    self.in_usg = in_usgs.join(',')
  end

  def out_usgs
    out_usg.present? ? out_usg.split(',') : []
  end

  def out_usgs=(out_usgs)
    self.out_usg = out_usgs.join(',')
  end

  def mib_info
    md = /(\d*\D+)(\d\/.*)/.match(self.port)
    return nil unless md
    return MibPort.where(switch_id: self.switch_id).where("port_desc like '#{md[1].upcase}%#{md[2]}'").first
  end

  private
  def create_zabbix_config
    host = self.switch
    zbx_agent = ZabbixAgent.new(ENV['zabbix_front_url'], ENV['zabbix_user'], ENV['zabbix_password'])
    host_info = zbx_agent.host_info(host)
    zbx_agent.create_port_conf(host_info, self)
  end
end
