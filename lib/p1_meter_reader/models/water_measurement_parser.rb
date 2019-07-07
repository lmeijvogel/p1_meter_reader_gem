require 'yaml'

module P1MeterReader
  module Models
    class WaterMeasurementParser
      def initialize(last_measurement)
        @last_measurement = last_measurement
      end

      def parse(message)
        message = message.strip

        if message =~ /USAGE/
          self.last_measurement += 1
        end

        # Return the current measurement by default, even if it's not updated:
        # The water usage is the same as before.
        self.last_measurement
      end

      protected

      attr_accessor :last_measurement
    end
  end
end
