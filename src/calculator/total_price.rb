require "#{$root}/src/calculator/base"
require "#{$root}/src/calculator/rule_applier/total_price_drop"

module Calculator
    class TotalPrice < Base
        def initialize
            @total_price = 0
            super
        end

        def add_to_total_price(item_price)
            @total_price = @total_price + item_price
        end

        def call
            return total_price if promotional_rules.empty?
            
            apply_rules(total_price)
            total_price
        end

        private

        def apply_rules(total_price)
            promotional_rules.each do |rule|
                @total_price = rule_applier(rule).call(total_price)
            end
        end

        attr_reader :total_price
    end
end