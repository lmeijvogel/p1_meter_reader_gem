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

    private
    def serial_port
      serial_port = SerialPort.new("/dev/ttyUSB0", 9600)
      serial_port.data_bits = 7
      serial_port.stop_bits = 1
      serial_port.parity = SerialPort::EVEN

      serial_port
    end
  end
end
