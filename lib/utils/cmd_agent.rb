require 'net/ssh'
require 'net/ssh/telnet'

class CmdAgent
  def initialize(ip, user, passwd, prompt = /[<\[]\S+[>\]]/)
    # @session = Net::SSH.start(ip, user, password: passwd)
    # @term = Net::SSH::Telnet.new("Session" => @session, "Prompt" => prompt)
    @term = Net::SSH::Telnet.new('Host' => ip, 'Username' => user,
                                 'Password' => passwd, 'Prompt' => prompt)

    # set no split screen, only work for huawei and h3c devices
    @term.cmd('system-view')
    @term.cmd('user-interface vty 0 4')
    @term.cmd('screen-length 0')
    @term.cmd('commit')
    @term.cmd('quit')
    @term.cmd('quit')
  end

  def run_cmd(cmd)
    @term.cmd(cmd)
  end

  def close
    @term.cmd('system-view')
    @term.cmd('user-interface vty 0 4')
    @term.cmd('undo screen-length')
    @term.cmd('commit')
    @term.cmd('quit')
    @term.cmd('quit')
    # @term.cmd('quit')
    # @term.close
  end
end
