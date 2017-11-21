require 'utils/output_parse'

describe 'OutputParse' do
  let(:h3c_op) { OutputParse.new }
  let(:hw_op) { OutputParse.new('HW') }
  let(:down_out) { 'GigabitEthernet1/0/15 current state: DOWN' }
  let(:h3c_out) do
    '''
display int g1/0/1
 GigabitEthernet1/0/1 current state: UP
 IP Packet Frame Type: PKTFMT_ETHNT_2, Hardware Address: 5cdd-7058-b1f9
 Description: to 7503e link1
 Loopback is not set
 Media type is optical fiber,Port hardware type is 1000_BASE_BX_U_SFP
 10Gbps-speed mode, full-duplex mode
 Link speed type is autonegotiation, link duplex type is autonegotiation
 Flow-control is not enabled
 The Maximum Frame Length is 9216
 Broadcast MAX-ratio: 100%
 Unicast MAX-ratio: 100%
 Multicast MAX-ratio: 100%
 Allow jumbo frame to pass
 PVID: 6
 Mdi type: auto
 Link delay is 0(sec)
 Port link-type: hybrid
  Tagged   VLAN ID : 6, 38
  Untagged VLAN ID : none
 Port priority: 0
 Peak value of input: 15180585 bytes/sec, at 2014-12-22 16:06:56
 Peak value of output: 80435006 bytes/sec, at 2014-12-12 09:55:44
 Last 300 seconds input:  13722 packets/sec 4521923 bytes/sec 4%
 Last 300 seconds output:  34185 packets/sec 46405680 bytes/sec 38%
 Input (total):  85040339688 packets, 28736553745726 bytes
         85036119716 unicasts, 3702977 broadcasts, 516981 multicasts, 0 pauses
 Input (normal):  85040339674 packets, - bytes
         85036119716 unicasts, 3702977 broadcasts, 516981 multicasts, 0 pauses
 Input:  13 input errors, 0 runts, 0 giants, 0 throttles
         8 CRC, 0 frame, - overruns, 5 aborts
         - ignored, - parity errors
 Output (total): 305692031118 packets, 409092530971821 bytes
         305691311030 unicasts, 130928 broadcasts, 589160 multicasts, 0 pauses
 Output (normal): 305692031118 packets, - bytes
         305691311030 unicasts, 130928 broadcasts, 589160 multicasts, 0 pauses
 Output: 0 output errors, - underruns, - buffer failures
         0 aborts, 0 deferred, 0 collisions, 0 late collisions
         0 lost carrier, - no carrier
    '''
  end

  let(:hw_out) do
    '''
disp int 10GE1/8/0/0
10GE1/8/0/0 current state : UP (ifindex: 10)
Line protocol current state : UP 
Description: 
Switch Port, TPID : 8100(Hex), The Maximum Frame Length is 9216
IP Sending Frames\' Format is PKTFMT_ETHNT_2, Hardware address is 200b-c736-9e01
Port Mode:   COMMON FIBER,     Port Split: -
Speed :              1000,     Loopback: NONE
Duplex:              FULL,     Negotiation: ENABLE 
Mdi   :                 - 
Last physical up time   : 2013-12-04 16:15:54
Last physical down time : 2013-12-04 16:15:45
Current system time: 2015-01-28 16:45:56
Statistics last cleared:2013-12-04 11:09:54
    Last 300 seconds input rate: 169028769 bits/sec, 14587 packets/sec
    Last 300 seconds output rate: 6507551 bits/sec, 7609 packets/sec
    Input peak rate 451280091 bits/sec, Record time: 2014-02-18 12:03:24
    Output peak rate 11999718 bits/sec, Record time: 2014-02-18 12:02:33
    Input :    596430588334887 bytes,       414193301239 packets
    Output:     27444591932576 bytes,       262807377563 packets
    Input: 
      Unicast:           414042272275,   Multicast:                13678677
      Broadcast:            137350201,   Jumbo:                           0
      Discard:                      0,   Total Error:                     0

      CRC:                          0,   Giants:                          0
      Jabbers:                      0,   Fragments:                       0
      Runts:                        0,   DropEvents:                      0
      Alignments:                   0,   Symbols:                         0
      Ignoreds:                     0,   Frames:                          0
                
    Output:
      Unicast:           260626859502,   Multicast:              1548986328
      Broadcast:            631531733,   Jumbo:                           0
      Discard:                      0,   Buffers Purged:                 10

    Input bandwidth utilization threshold : 90.00%
    Output bandwidth utilization threshold: 90.00%
    Last 300 seconds input utility rate:  17%
    Last 300 seconds output utility rate: 0.65%

    '''
  end

  describe '#parse' do
    it 'should ok' do
      down_out.should match(/current state\s*: down/i)
      h3c_out.should match(/current state\s*: up/i)
      hw_out.should match(/current state\s*: Up/i)
    end

    it 'should return down result for down output' do
      ret = h3c_op.parse(down_out)
      ret.should be_a_kind_of(Array)
      ret.should eq(['DOWN', -1, -1, -1, -1, -1])

      ret = hw_op.parse(down_out)
      ret.should be_a_kind_of(Array)
      ret.should eq(['DOWN', -1, -1, -1, -1, -1])
    end

    it 'should return correct result for h3c' do
      h3c_op.parse(h3c_out).should eq(['UP', 4, 38, 3, 0, 10000])
    end

    it 'should return correct result for hw' do
      hw_op.parse(hw_out).should eq(['UP', 17, 0.65, 0, 10, 1000])
    end
  end
end
