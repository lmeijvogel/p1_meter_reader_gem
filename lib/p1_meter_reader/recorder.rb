require "p1_meter_reader/models/measurement_parser"
require "p1_meter_reader/models/water_measurement_parser"

module P1MeterReader
  class Recorder
    def initialize(p1_data_source:, water_data_source: nil)
      self.measurement_parser = Models::MeasurementParser.new
      self.water_measurement_parser = Models::WaterMeasurementParser.new
      self.p1_data_source = p1_data_source
      self.water_data_source = water_data_source
    end

    def collect_data(&block)
      loop do
        # Parse water_message first, since it will "tick" very frequently, while the p1 source only ticks every 10 seconds.
        water_message = water_data_source&.read

        p1_message = p1_data_source.read

        measurement = measurement_parser.parse(p1_message)

        if water_message
          water_message = water_data_source.read

          measurement.water = water_measurement_parser.parse(water_message)
        end

        block.yield measurement
      end
    end

    protected

    attr_accessor :measurement_parser, :water_measurement_parser, :p1_data_source, :water_data_source
  end
end
