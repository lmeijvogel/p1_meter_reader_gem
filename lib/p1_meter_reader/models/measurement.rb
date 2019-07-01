module P1MeterReader
  module Models
    class Measurement
      attr_accessor :time_stamp, :time_stamp_utc, :stroom_dal, :stroom_piek, :stroom_current, :gas

      def time_stamp_current_minute
        self.time_stamp.strftime("%d-%m-%y %H:%M")
      end

      def time_stamp_next_minute
        next_minute = self.time_stamp + 1.0/(24*60)
        next_minute.strftime("%d-%m-%y %H:%M")
      end

      def to_s
        date = self.time_stamp.strftime("%d-%m-%y %H:%M:%S")

        "#{date}: #{stroom_dal} - #{stroom_piek} - #{stroom_current} - #{gas}"
      end
    end
  end
end
