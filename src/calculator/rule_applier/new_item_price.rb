require "#{$root}/src/calculator/rule_applier/base"

module Calculator
    module RuleApplier
        class NewItemPrice < Base
            def call(item_price, item_count)
                return item_count * rule[:new_price] if item_count >= rule[:required_bought_items]
                
                item_count * item_price
            end
        end
    end
end