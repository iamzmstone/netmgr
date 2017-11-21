require 'utils/cmd_agent'
require 'utils/output_parse'

namespace :check do
  desc 'check port traffic usage of switches'
  task(port_usage: :environment) do
    Switch.all.each do |s|
      puts s.name
      agent = CmdAgent.new(s.ip, s.login.present? ? s.login : ENV['sw_ftp_user'], s.password.present? ? s.password : ENV['sw_ftp_pass'])
      op = OutputParse.new(s.model.split('-')[0])
      s.ports.each do |p|
        data = op.parse(agent.run_cmd('disp int ' + p.port))
        puts p.port + ':' + data.inspect
        if data[0] == 'UP' || data[0] == 'DOWN'
          p.status = data[0]
          # keep at max 10 input/output usgs items
          a = p.in_usgs
          a << data[1]
          a.shift if a.size > 10
          p.in_usgs = a

          a = p.out_usgs
          a << data[2]
          a.shift if a.size > 10
          p.out_usgs = a

          p.in_err = data[3]
          p.out_err = data[4]
          p.speed = data[5]

          p.status = 'ALARM' if data[1] > 80 || data[2] > 80  # Alarm status for usage over 80%
          p.save

          # UsageMailer.usage_warn(p).deliver! if p.status != 'UP'
        end
      end
      agent.close
    end
  end

  desc 'calculate and merge onu_mac_cnt model'
  task(onu_mac_cnt: :environment) do
    SpOnu.all.each do |onu|
      cnt = MacIp.where(sn: onu.sn, olt: onu.olt, interface: onu.interface, oid: onu.oid).count
      omc = onu.onu_mac_cnt
      if omc
        unless cnt == omc.mac_cnt
          omc.mac_cnt = cnt
          omc.save
        end
      else
        OnuMacCnt.create(sp_onu_id: onu.id, mac_cnt: cnt)
      end
    end
  end
end
