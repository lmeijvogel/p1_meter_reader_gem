require 'io/wait'

module P1MeterReader
  module DataParsing
    class StreamSplitter
      def initialize(message_start, input:)
        @message_start = message_start
        @stream = input
      end

      def read
        result = ""
        begin
          result = @stream.readline
        end while result.strip != @message_start

        loop do
          line = @stream.readline
          result << line

          return result if line.strip == "!"
        end
      end

      def ready?
        @stream.ready?
      end
    end
  end
end
