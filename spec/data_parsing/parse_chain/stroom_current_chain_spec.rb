require 'spec_helper'

describe P1MeterReader::DataParsing::ParseChain::StroomCurrentChain do
  describe :can_handle? do
    subject { P1MeterReader::DataParsing::ParseChain::StroomCurrentChain.new.can_handle?(line) }

    context "when the line starts with 1-0:1.7.0" do
      let(:line) { "1-0:1.7.0(00000.379*kW)" }

      it { should == true }
    end

    context "when the line starts with something else" do
      let(:line) { "1-0:2.7.0(00000.251*kWh)" }

      it { should == false }
    end
  end

  describe :handle do
    subject { P1MeterReader::DataParsing::ParseChain::StroomCurrentChain.new }

    let(:output) { P1MeterReader::Models::Measurement.new }
    let(:next_line) { "next line" }
    let(:lines) { ["1-0:1.7.0(00000.379*kW)", next_line].to_enum }

    it "sets the correct amount in :stroom_current" do
      subject.handle(lines, output)

      expect(output.stroom_current).to eq(0.379)
    end

    it "advances the enumerator" do
      subject.handle(lines, output)

      expect(lines.next).to eq(next_line)
    end
  end
end
