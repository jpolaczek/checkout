module Calculator
    class Base
        def initialize
            @promotional_rules = {}
        end

        def set_rules(rules)
            @promotional_rules = rules
        end

        private

        def rule_applier(rule)
            Object.const_get("Calculator::RuleApplier::#{rule[:type].split('_').collect(&:capitalize).join}").new(rule)
        end

        attr_reader :promotional_rules
    end
end