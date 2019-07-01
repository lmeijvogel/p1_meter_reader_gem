require "spec_helper"

describe :kWh do
  describe :instantiation do
    context "when the parameter is a Float" do
      it "stores it correctly" do
        expect(kWh(12.34).to_f).to eq 12.34
      end
    end

    context "when the parameter is a Kwh" do
      it "stores it correctly" do
        expect(kWh(Kwh.new(12.34)).to_f).to eq 12.34
      end
    end
  end

  describe :== do
    context "when the other value is a Float" do
      it "returns false" do
        expect(kWh(12) == 10).to be_falsy
      end
    end

    context "when the other value is a kWh" do
      it "works correctly" do
        expect(kWh(12) == kWh(12)).to be_truthy
        expect(kWh(12) == kWh(13)).to be_falsy
      end
    end
  end

  describe :subtraction do
    context "when the other value is a kWh" do
      it "works correctly" do
        expect(kWh(12) - kWh(4)).to eq kWh(8)
      end
    end

    context "when the other value is a Float" do
      it "raises an error" do
        expect {
          kWh(12) - 10
        }.to raise_error(StandardError)
      end
    end

  end
end
