require 'p1_meter_reader/data_parsing/parse_chain/chainable'

module P1MeterReader
  module DataParsing
    module ParseChain
      class SkipLineChain < Chainable
        def can_handle?(_)
          true
        end

        def handle(lines_enumerator, _)
          lines_enumerator.next
        end
      end
    end
  end
end
