require 'spec_helper'

describe P1MeterReader::DataParsing::ParseChain::StroomDalChain do
  describe :can_handle? do
    subject { P1MeterReader::DataParsing::ParseChain::StroomDalChain.new.can_handle?(line) }

    context "when the line starts with 1-0:1.8.1" do
      let(:line) { "1-0:1.8.1(00557.379*kWh)" }

      it { should == true }
    end

    context "when the line starts with something else" do
      let(:line) { "1-0:1.8.2(00610.251*kWh)" }

      it { should == false }
    end
  end

  describe :handle do
    subject { P1MeterReader::DataParsing::ParseChain::StroomDalChain.new }

    let(:output) { P1MeterReader::Models::Measurement.new }
    let(:next_line) { "next line" }
    let(:lines) { ["1-0:1.8.1(00557.379*kWh)", next_line].to_enum }

    it "sets the correct amount in :stroom_dal" do
      subject.handle(lines, output)

      expect(output.stroom_dal).to eq(kWh(557.379))
    end

    it "notes the previous value" do
      subject.handle(lines, output)

      expect(subject.last_value).to eq(kWh(557.379))
    end

    it "advances the enumerator" do
      subject.handle(lines, output)

      expect(lines.next).to eq(next_line)
    end
  end
end
