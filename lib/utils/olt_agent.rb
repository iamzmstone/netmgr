require 'net/telnet'

class OltAgent
  def initialize(ip, user, passwd, prompt = /[#>]\s?\z/n)
    @session = Net::Telnet::new('Host' => ip, 'Prompt' => prompt, 'Timeout' => 120)
    @session.cmd("#{user}\n#{passwd}")
    @session.cmd('terminal length 0')   # no split screen
  end

  def run_cmd(cmd)
    @session.cmd(cmd)
  end

  def close
    @session.close
  end

  def onu_status(model, interface, onu_id)
    output = ''
    if model.downcase == 'gpon'
      cmd = "show gpon onu state gpon-olt_1/#{interface}"
      output += "**** command: PON口#{interface}的ONU状态\n"
      rst = run_cmd(cmd)
      output += "#{rst}\n+++++++++++++++++++++++++++\n\n"

      cmd = "show run int gpon-onu_1/#{interface}:#{onu_id}"
      output += "**** command: ONU#{interface}:#{onu_id}接口配置\n"
      rst = run_cmd(cmd)
      rst = Iconv.iconv('UTF-8', 'GBK', rst)[0]
      output += "#{rst}\n+++++++++++++++++++++++++++\n\n"

      cmd = "show onu running config gpon-onu_1/#{interface}:#{onu_id}"
      output += "**** command: ONU#{interface}:#{onu_id}下发配置\n"
      rst = run_cmd(cmd)
      output += "#{rst}\n+++++++++++++++++++++++++++\n\n"

      cmd = "show mac gpon onu gpon-onu_1/#{interface}:#{onu_id}"
      output += "**** command: ONU#{interface}:#{onu_id}的下挂MAC地址信息\n"
      rst = run_cmd(cmd)
      output += "#{rst}\n+++++++++++++++++++++++++++\n\n"

      cmd = "show pon power onu-rx gpon-onu_1/#{interface}:#{onu_id}"
      output += "**** command: ONU#{interface}:#{onu_id}的接收光功率信息\n"
      rst = run_cmd(cmd)
      output += "#{rst}\n+++++++++++++++++++++++++++\n\n"

      cmd = "show int gpon-onu_1/#{interface}:#{onu_id}"
      output += "**** command: ONU#{interface}:#{onu_id}接口流量信息\n"
      rst = run_cmd(cmd)
      output += "#{rst}\n+++++++++++++++++++++++++++\n\n"

      cmd = "show pon onu uncfg sn loid"
      output += "**** command: 未注册的ONU信息\n"
      rst = run_cmd(cmd)
      output += "#{rst}\n+++++++++++++++++++++++++++\n\n"
    else
      # cmd = "show onu all-status epon-olt_0/#{interface}"
      # output += "**** command: #{cmd}\n"
      # rst = run_cmd(cmd)
      # output += "#{rst}\n+++++++++++++++++++++++++++\n\n"

      cmd = "show run int epon-onu_0/#{interface}:#{onu_id}"
      output += "**** command: ONU#{interface}:#{onu_id}接口配置\n"
      rst = run_cmd(cmd)
      rst = Iconv.iconv('UTF-8', 'GBK', rst)[0]
      output += "#{rst}\n+++++++++++++++++++++++++++\n\n"

      cmd = "show onu running config epon-onu_0/#{interface}:#{onu_id}"
      output += "**** command: ONU#{interface}:#{onu_id}下发配置\n"
      rst = run_cmd(cmd)
      output += "#{rst}\n+++++++++++++++++++++++++++\n\n"

      cmd = "show mac epon onu epon-onu_0/#{interface}:#{onu_id}"
      output += "**** command: ONU#{interface}:#{onu_id}的下挂MAC地址信息\n"
      rst = run_cmd(cmd)
      output += "#{rst}\n+++++++++++++++++++++++++++\n\n"

      # cmd = "show remote onu port info epon-onu_0/#{interface}:#{onu_id}"
      # output += "**** command: #{cmd}\n"
      # rst = run_cmd(cmd)
      # output += "#{rst}\n+++++++++++++++++++++++++++\n\n"

      # cmd = "show int epon-onu_0/#{interface}:#{onu_id}"
      # output += "**** command: #{cmd}\n"
      # rst = run_cmd(cmd)
      # output += "#{rst}\n+++++++++++++++++++++++++++\n\n"

      cmd = "show remote onu transceiver info epon-onu_0/#{interface}:#{onu_id}"
      output += "**** command: ONU#{interface}:#{onu_id}的接收光功率信息\n"
      rst = run_cmd(cmd)
      output += "#{rst}\n+++++++++++++++++++++++++++\n\n"

      cmd = "show onu unauthentication"
      output += "**** command: 未注册的ONU信息\n"
      rst = run_cmd(cmd)
      output += "#{rst}\n+++++++++++++++++++++++++++\n\n"
    end
    output
  end
end
