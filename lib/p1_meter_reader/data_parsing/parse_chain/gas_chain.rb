require 'p1_meter_reader/data_parsing/parse_chain/chainable'

module P1MeterReader
  module DataParsing
    module ParseChain
      class GasChain < Chainable
        def can_handle?(line)
          line.start_with?('0-1:24.2.1')
        end

        def handle(lines_enumerator, output)
          line = lines_enumerator.next

          match = line.match(/\((\d+\.\d+)\*m3\)/)

          output.gas = match[1].to_f if match
        end
      end
    end
  end
end
