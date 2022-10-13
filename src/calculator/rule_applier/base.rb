module Calculator
    module RuleApplier
        class Base
            def initialize(rule)
                @rule = rule
            end

            private

            attr_reader :rule
        end
    end
end