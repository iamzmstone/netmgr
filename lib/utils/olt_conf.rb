class OltConf
  attr_reader :onus
  def initialize(config_file, model = 'C300')
    return nil unless File.exists?(config_file)
    @onus = {}
    lines = IO::readlines(config_file)
    rex_int_olt = /^interface (e|g)pon-olt_\d\/(\d+\/\d+)$/
    rex_int_onu = /^interface (e|g)pon-onu_\d\/(\d+\/\d+):(\d+)$/
    rex_onu = model == 'C300' ? /onu (\d+) type \S+ (sn|loid) (\S+)/ : /onu (\d+) type \S+ (sn|loid|mac) (\S+)/
    int_olt_flag = false
    int_onu_flag = false

    intf = ''
    pon_type = 'gpon'
    current_onu = nil

    lines.each do |line|
      begin
        line.strip!
        # match olt interface section
        if int_olt_flag
          md = rex_onu.match(line)
          @onus[intf][md[1]] = { sn: md[3] } if md
          int_olt_flag = false if line =~ /^!$/
        else
          md = rex_int_olt.match(line)
          if md
            pon_type = md[1] == 'e' ? 'epon' : 'gpon'
            intf = md[2]
            @onus[intf] = {}
            int_olt_flag = true
          end
        end

        next if int_olt_flag

        # match onu interface section
        if int_onu_flag
          up_rex = pon_type == 'gpon' ? /tcont (\d+) .* profile UP-(\d+M)/i : /sla-profile (.*) vport/
          down_rex = pon_type == 'gpon' ? /gemport (\d+) .* downstream DOWN-(\d+M)/i : /sla-profile (.*) vport/
          md = up_rex.match(line)
          if md
            bandwidth = pon_type == 'gpon' ? md[2] : md[1]
            current_onu.merge!(up: bandwidth)
          end
          md = down_rex.match(line)
          if md
            bandwidth = pon_type == 'gpon' ? md[2] : md[1]
            current_onu.merge!(down: bandwidth)
          end
          int_onu_flag = false if line =~ /^!$/
        else
          md = rex_int_onu.match(line)
          if md
            current_onu = @onus[md[2]][md[3]]
            int_onu_flag = true
          end
        end
      rescue => e
        #puts "Error: #{e.to_s}"
        next
      end
    end
  end
end
