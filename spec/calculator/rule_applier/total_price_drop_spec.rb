require "#{$root}/src/calculator/rule_applier/total_price_drop"

RSpec.describe Calculator::RuleApplier::TotalPriceDrop do
    let(:rule_applier) { described_class.new(rule) }

    describe '#call' do
        subject { rule_applier.call(price) }

        let(:rule) { { type: 'total_price_drop', total_price_required: 6000, drop_percentage: 10 } }
        let(:price) { 5010 }

        it 'returns final price' do
            expect(subject).to eq 5010
        end

        context 'when rule condition passed' do
            let(:price) { 6010 }

            it 'calculates new total price' do
                expect(subject).to eq 5409
            end
        end
    end
end