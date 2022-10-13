require "#{$root}/src/calculator/base"
require "#{$root}/src/calculator/rule_applier/new_item_price"
require 'byebug'


module Calculator
    class ItemPrice < Base
        ITEM_PRICES = {
            1 => 925,
            2 => 4500,
            3 => 1995
        }

        private_constant :ITEM_PRICES

        def set_rules(rules)
            @promotional_rules = rules.inject({}) do |rule_hash, rule|
                rule_hash[rule[:id]] = rule
                rule_hash
            end
        end

        def call(item_id:, item_count:)
            return apply_rule_for_item(
                item_id, item_count, fetch_rule(item_id)
            ) if fetch_rule(item_id)

            ITEM_PRICES[item_id] * item_count
        end

        private

        def apply_rule_for_item(id, item_count, rule)
            rule_applier(fetch_rule(id)).call(ITEM_PRICES[id], item_count)
        end

        def fetch_rule(id)
            promotional_rules[id]
        end

        attr_reader :promotional_rules
    end
end