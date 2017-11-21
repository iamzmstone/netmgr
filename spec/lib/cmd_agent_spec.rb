require 'utils/cmd_agent'

describe 'command agent' do
  let(:agent) { CmdAgent.new('33.166.127.1', 'zengm', '85887656') }
  let(:bad_agent) { CmdAgent.new('33.166.127.1', 'zengm', 'wrong') }

  describe '.new' do
    it 'should create agent with correct credential' do
      agent.should_not be_nil
    end

    it 'should raise error with wrong credentail' do
      # expect { bad_agent }.to raise_error
    end
  end

  describe '#run_cmd' do
    it 'should execute disp version command and return result' do
      agent.run_cmd('disp version').should match(/Copyright \(C\)/i)
    end

    it 'should execute disp int command return result' do
      agent.run_cmd('disp int g1/0/1').should match(/bytes\/sec (\d+)%.*bytes\/sec (\d+)%.*(\d+) input errors,.*(\d+) output errors,/mi)
      agent.close
    end
  end
end
