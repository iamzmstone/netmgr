class SwConf
  attr_reader :vlans
  def initialize(config_file, model = 'H3C')
    @vlans = []
    vlan_flag = false
    i = 0

    lines = IO::readlines(config_file)
    lines.each do |line|
      line.strip!
      if vlan_flag  # vlan interface config begin
        md = /description\s+(.*)/.match(line)
        @vlans[i][:desc] = md[1] if md
        md =  /ip address ([\d\.]+) ([\d\.]+)/.match(line)
        @vlans[i][:ips] << { gw: md[1], nm: md[2] } if md
        if line =~ /^#\s*/
          i += 1
          vlan_flag = false
        end
      else
        md = /interface (Vlanif|Vlan-interface)(\d+)/.match(line)
        if md
          vlan_flag = true
          @vlans[i] = { vlan: md[2], desc: nil, ips: [] }
        else
          next
        end
      end
    end
  end
end
