module P1MeterReader
  module DataParsing
    module KwhReader
      def read(line)
        match = line.match(/\((.*)\*kWh\)/)

        kWh(match[1]) if match
      end

      module_function :read
    end
  end
end
