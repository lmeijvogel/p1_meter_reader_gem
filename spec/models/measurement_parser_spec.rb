require 'spec_helper'
require 'timecop'

describe "full integration" do
  describe :parse do
    let(:input) do <<-INPUT
/XMX5XMXABCE100129872

0-0:96.1.1(4B414145303031343535343236383133)
1-0:1.8.1(00557.379*kWh)
1-0:1.8.2(00610.251*kWh)
1-0:2.8.1(00000.000*kWh)
1-0:2.8.2(00000.000*kWh)
0-0:96.14.0(0002)
1-0:1.7.0(0000.69*kW)
1-0:2.7.0(0000.00*kW)
0-0:17.0.0(999*A)
0-0:96.3.10(1)
0-0:96.13.1()
0-0:96.13.0()
0-1:96.1.0(3238303131303038333338303831393133)
0-1:24.1.0(03)
0-1:24.3.0(140228200000)(24)(60)(1)(0-1:24.2.0)(m3)
(00742.914)
0-1:24.4.0(1)
!
INPUT
    end

    before do
      Timecop.freeze
    end

    after do
      Timecop.return
    end

    subject { P1MeterReader::Models::MeasurementParser.new.parse(input) }

    its(:time_stamp)  { should == DateTime.now }
    its(:stroom_dal)  { should == kWh(557.379) }
    its(:stroom_piek) { should == kWh(610.251) }
    its(:stroom_current) { should == 0.69 }
    its(:gas)         { should == 742.914 }
  end
end
