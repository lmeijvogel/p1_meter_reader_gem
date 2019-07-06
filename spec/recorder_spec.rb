require 'spec_helper'
require 'p1_meter_reader/recorder'


class MockP1Source
  def initialize(number_of_inactive_cycles:)
    @number_of_inactive_cycles = number_of_inactive_cycles
  end

  def ready?
    @number_of_inactive_cycles -= 1

    @number_of_inactive_cycles == 0
  end

  def read
    if @number_of_inactive_cycles > 0
      raise "'read' called when not ready!"
    end

    return "1-0:1.8.2(00611.553*kWh)\n"
  end
end

class MockWaterSource
  def read
    "USAGE: 123"
  end
end

describe P1MeterReader::Recorder do
  it "reads water measurements until a p1 measurement is available" do
    mock_p1_source = MockP1Source.new(number_of_inactive_cycles: 4)
    mock_water_source = MockWaterSource.new

    subject = P1MeterReader::Recorder.new(p1_data_source: mock_p1_source, water_data_source: mock_water_source)

    subject.collect_measurement do |measurement|
      expect(measurement.stroom_piek).to eq(Kwh.new(611.553))
      expect(measurement.water).to be_within(0.0001).of(0.0004)
    end
  end
end
