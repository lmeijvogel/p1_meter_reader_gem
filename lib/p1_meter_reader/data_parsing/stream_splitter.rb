require 'serialport'

module P1MeterReader
  module DataParsing
    class StreamSplitter
      def initialize(message_start, input: serial_port)
        @message_start = message_start
        @stream = input.each_line
      end

      def read
        while (@stream.peek).strip != @message_start
          @stream.next
        end

        result = ""

        loop do
          line = @stream.next
          result << line

          return result if line.strip == "!"
        end
      end

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
end
