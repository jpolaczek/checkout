require "#{$root}/src/calculator/item_price"

RSpec.describe Calculator::ItemPrice do
    let(:calculator) { described_class.new }

    describe '#call' do
        subject { calculator.call(item_id: item_id, item_count: item_count) }

        let(:item_id) { 1 }
        let(:item_count) { 4 }

        it 'calculates the price for products' do
            expect(subject).to eq 3700
        end

        context 'when rule present' do
            let(:rule) { { type: 'new_item_price', required_bought_items: 3, new_price: 850, id: 1 } }

            before { calculator.set_rules([rule]) }

            it 'calculates the price for products' do
                expect(subject).to eq 3400
            end
        end
    end
end