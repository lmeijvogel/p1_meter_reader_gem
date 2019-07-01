require 'spec_helper'

describe P1MeterReader::DataParsing::ParseChain::GasChain do
  describe :can_handle? do
    subject { P1MeterReader::DataParsing::ParseChain::GasChain.new.can_handle?(line) }

    context "when the line starts with '0-1:24.3.0'" do
      let(:line) { '0-1:24.3.0(140228200000)(24)(60)(1)(0-1:24.2.0)(m3)' }
      it { should == true }
    end

    context "when the line does not start with '0-1:24.3.0'" do
      let(:line) { '0-1:24.3.1(140228200000)(24)(60)(1)(0-1:24.2.0)(m3)' }

      it { should == false }
    end
  end

  describe :handle do
    subject { P1MeterReader::DataParsing::ParseChain::GasChain.new }

    let(:next_line) { "The next line" }
    let(:lines) { ['0-1:24.3.0(140228200000)(24)(60)(1)(0-1:24.2.0)(m3)', '(00742.914)', next_line].to_enum }

    let(:output) { P1MeterReader::Models::Measurement.new }

    it "sets :gas to the correct value" do
      subject.handle(lines, output)
      output.gas.should == 742.914
    end

    it "moves the enumerator to the next line" do
      subject.handle(lines, output)
      lines.next.should == next_line
    end
  end
end
