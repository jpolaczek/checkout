require "#{$root}/src/calculator/rule_applier/base"

module Calculator
    module RuleApplier
        class TotalPriceDrop < Base
            def call(total_price)
                return (total_price - (total_price * drop_percentage)).ceil if total_price > total_price_required

                total_price
            end

            private

            def drop_percentage
                Float(rule[:drop_percentage])/100
            end

            def total_price_required
                rule[:total_price_required]
            end
        end
    end
end