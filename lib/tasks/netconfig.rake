require 'net/sftp'
require 'utils/cmd_agent'
require 'utils/sw_conf'

namespace :netconfig do
  CFG_DIR = 'netconfig'
  OUTDIR = 'output'

  desc 'ftp download config files of switches'
  task(switch: :environment) do
    puts Time.now()
    Switch.all.each do |s|
      puts "#{s.name} #{s.ip}"
      begin
        Net::SFTP.start(s.ip, s.login.present? ? s.login : ENV['sw_ftp_user'], password: (s.password.present? ? s.password : ENV['sw_ftp_pass'])) do |sftp|
          sftp.download!('/startup.cfg', "#{CFG_DIR}/#{s.name}.cfg") if s.model =~ /^H3C/
          sftp.download!('/vrpcfg.zip', "#{CFG_DIR}/#{s.name}.zip") if s.model =~ /^HW/
        end
      rescue => e
        puts "Error: " + e.to_s
      end
    end

    Dir.glob("#{CFG_DIR}/*.zip").each do |zipfile|
      `unzip #{zipfile} -d #{CFG_DIR}`
      `rm #{zipfile}`
      name = zipfile.split('/')[1].split('.')[0]
      `mv #{CFG_DIR}/vrpcfg.cfg #{CFG_DIR}/#{name}.cfg`
    end
  end # task switch

  desc 'read downloaded config file of switches and import to vlan table'
  task(vlan: :environment) do
    puts Time.now()
    Vlan.delete_all
    Switch.all.each do |s|
      if File.exists?("#{CFG_DIR}/#{s.name}.cfg")
        puts "#{s.name}..."
        sc = SwConf.new("#{CFG_DIR}/#{s.name}.cfg", s.model.split('-')[0])
        sc.vlans.each do |vlan|
          vlan[:ips].each do |ip|
            Vlan.create(switch_id: s.id, vlan: vlan[:vlan], remark: vlan[:desc], gateway: ip[:gw], netmask: ip[:nm])
          end
        end
      end
    end
  end # task vlan

  desc 'connect to each switch and generate arpall.txt'
  task(gen_arp_all: :environment) do
    puts Time.now()
    f = File.new("#{OUTDIR}/arpall.txt", 'w')
    Switch.all.each do |s|
      puts "#{s.name} #{s.ip}"
      begin
        agent = CmdAgent.new(s.ip, s.login.present? ? s.login : ENV['sw_ftp_user'], s.password.present? ? s.password : ENV['sw_ftp_pass'])
        f.puts(agent.run_cmd('display arp'))
        agent.close
      rescue => e
        puts "Error: " + e.to_s
      end
    end
    f.close
  end
end
