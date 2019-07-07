require "p1_meter_reader/models/measurement_parser"
require "p1_meter_reader/models/water_measurement_parser"

module P1MeterReader
  class Recorder
    def initialize(p1_data_source:, water_data_source: nil, water_measurement_parser: nil)
      self.measurement_parser = Models::MeasurementParser.new
      self.water_measurement_parser = water_measurement_parser
      self.p1_data_source = p1_data_source
      self.water_data_source = water_data_source
    end

    def collect_data(&block)
      loop do
        collect_measurement(&block)
      end
    end

    def collect_measurement(&block)
      water_message = nil
      water_value = nil

      begin
        # Keep parsing water messages since they occur much more frequently than p1 messages,
        # Parsing the message also updates the internal water_measurement_parser values
        water_message = water_data_source&.read

        if water_message
          water_value = water_measurement_parser&.parse(water_message)
        end
      end while !p1_data_source.ready?

      p1_message = p1_data_source.read

      measurement = measurement_parser.parse(p1_message)

      if water_value
        measurement.water = water_value
      end

      block.yield measurement
    end

    protected

    attr_accessor :measurement_parser, :water_measurement_parser, :p1_data_source, :water_data_source
  end
end
