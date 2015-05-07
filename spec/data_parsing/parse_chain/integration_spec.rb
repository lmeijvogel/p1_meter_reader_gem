require 'spec_helper'
require 'ostruct'

class TestChainable < P1MeterReader::DataParsing::ParseChain::Chainable
  def can_handle?(line)
    line =~ /true/
  end

  def handle(lines_enumerator, output)
    lines_enumerator.next

    output.value = true
  end
end

describe P1MeterReader::DataParsing::ParseChain::Chainable do
  describe "integration" do
    let(:output) { OpenStruct.new }

    subject { TestChainable.new }

    context "when the chainable can handle the lines" do
      let(:lines) { [ "true jaja" ].to_enum }

      it "handles them" do
        subject.try(lines, output).should == true
      end
    end

    context "when the chainable can't handle the lines" do
      let(:next_chainable) { double("handler") }

      let(:lines) { [ "false jaja" ].to_enum }

      before do
        subject.next = next_chainable
      end

      it "passes it to the next in the chain" do
        next_chainable.should_receive(:try).with(lines, output)

        subject.try(lines, output)
      end
    end
  end
end
