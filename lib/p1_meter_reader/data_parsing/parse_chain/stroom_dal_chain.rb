require 'p1_meter_reader/data_parsing/parse_chain/chainable'
require 'p1_meter_reader/data_parsing/kwh_reader'

module P1MeterReader
  module DataParsing
    module ParseChain
      class StroomDalChain < Chainable
        # This is primarily for testing
        attr_accessor :last_value

        def initialize(next_chain = nil)
          super
          self.last_value = kWh(0.0)
        end

        def can_handle?(line)
          line.start_with? ("1-0:1.8.1")
        end

        def handle(lines_enumerator, output)
          line = lines_enumerator.next

          value = KwhReader.read(line)

          if value
            output.stroom_dal = value
            output.diff_stroom_dal = value - last_value

            self.last_value = value
          end
        end
      end
    end
  end
end
