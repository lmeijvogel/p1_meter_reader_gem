module P1MeterReader
  module DataParsing
    module ParseChain
      class Chainable
        def initialize(next_chain = nil)
          @next = next_chain
        end

        def next=(chainable)
          @next=chainable
        end

        def try(lines_enumerator, output)
          if can_handle?(lines_enumerator.peek)
            handle(lines_enumerator, output)
          else
            next_chain = @next || :no_next_chain

            next_chain.try(lines_enumerator, output)
          end
        end
      end
    end
  end
end
