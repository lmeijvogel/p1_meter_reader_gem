require 'p1_meter_reader/data_parsing/parse_chain/chainable'
require 'p1_meter_reader/data_parsing/kwh_reader'

module P1MeterReader
  module DataParsing
    module ParseChain
      class StroomCurrentChain < Chainable
        def can_handle?(line)
          line.start_with? ("1-0:1.7.0")
        end

        def handle(lines_enumerator, output)
          line = lines_enumerator.next

          match = line.match(/\((.*)\*kW\)/)
          output.stroom_current = match[1].to_f if match
        end
      end
    end
  end
end
