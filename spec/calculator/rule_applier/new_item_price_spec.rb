require "#{$root}/src/calculator/rule_applier/new_item_price"

RSpec.describe Calculator::RuleApplier::NewItemPrice do
    let(:rule_applier) { described_class.new(rule) }

    describe '#call' do
        subject { rule_applier.call(item_price, item_count) }

        let(:rule) { { required_bought_items: 3, new_price: 850, id: 1 } }
        let(:item_price) { 900 }
        let(:item_count) { 2 }

        it 'calculates final price' do
            expect(subject).to eq 1800
        end

        context 'when rule condition passed' do
            let(:item_count) { 4 }

            it 'calculates final price based on rule provided new price' do
                expect(subject).to eq 3400
            end
        end
    end
end