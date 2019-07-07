require 'yaml'

module P1MeterReader
  module Models
    class WaterMeasurementParser
      def initialize
        @storage_filename = File.join(ENV["HOME"], "last_water_measurement_state.yml")
        @cycles_between_backups = 20
        @current_position_in_backup_cycle = 0

        init_from_file
      end

      def parse(message)
        message = message.strip

        if message =~ /USAGE/
          self.last_measurement += 1

          backup_if_necessary
        end

        # Return the current measurement by default, even if it's not updated:
        # The water usage is the same as before.
        self.last_measurement
      end

      protected

      attr_accessor :last_measurement

      private

      def backup_if_necessary
        @current_position_in_backup_cycle += 1

        return if @current_position_in_backup_cycle < @cycles_between_backups

        to_file

        @current_position_in_backup_cycle = 0
      end

      # We store the current state to file because we only receive increments from the water sensor,
      # as opposed to absolute numbers from the p1 interface.
      def init_from_file
        if ENV["ENVIRONMENT"] == "production" && File.exist?(@storage_filename)
          content = YAML.safe_load(File.read(@storage_filename))

          self.last_measurement = content["last_measurement"].to_f
        else
          self.last_measurement = 0
        end
      end

      def to_file
        return if ENV["ENVIRONMENT"] != "production"

        File.open(@storage_filename, "w") do |file|
          yaml = {
            "last_measurement" => self.last_measurement
          }.to_yaml

          file.puts(yaml)
        end
      end
    end
  end
end
