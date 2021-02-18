module P1MeterReader
  module DataParsing
    class StreamSplitter
      def initialize(message_start, input:)
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

          return result if line.strip.start_with?("!")
        end
      end

    end
  end
end
