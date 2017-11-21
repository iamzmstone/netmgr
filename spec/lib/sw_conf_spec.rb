require 'utils/sw_conf'

CONF_DIR = 'netconfig'
describe 'SwConf' do
  let(:sw) { SwConf.new("#{CONF_DIR}/城东公安核心:Huawei12800.cfg", 'HW') }
  let(:sw_vlans) { sw.vlans }
  describe '.new' do
    it 'should return correct object' do
      sw.should_not be_nil
    end

    it 'should return correct vlans' do
      sw_vlans.should include({ vlan: '42', desc: 'to-7503e',
                                ips: [{ gw: '33.165.8.30', nm: '255.255.255.252' }]
                              })
    end
  end
end
