require "p1_meter_reader/models/measurement_parser"

module P1MeterReader
  class Recorder
    def initialize(measurement_source:)
      self.measurement_parser = Models::MeasurementParser.new
      self.measurement_source = measurement_source
    end

    def collect_data(&block)
      loop do
        message = measurement_source.read

        measurement = measurement_parser.parse(message)

        yield measurement
      end
    end

    protected
    attr_accessor :measurement_parser, :measurement_source
  end
end
