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

    it "has the correct time_stamp" do
      expect(subject.time_stamp).to eq(DateTime.now)
    end

    it "has the correct stroom_dal" do
      expect(subject.stroom_dal).to eq(kWh(557.379))
    end

    it "has the correct stroom_piek" do
      expect(subject.stroom_piek).to eq(kWh(610.251))
    end

    it "has the correct stroom_current" do
      expect(subject.stroom_current).to eq(0.69)
    end

    it "has the correct gas" do
      expect(subject.gas).to eq(742.914)
    end
  end
end
