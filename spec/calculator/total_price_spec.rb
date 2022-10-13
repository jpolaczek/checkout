require "#{$root}/src/calculator/total_price"

RSpec.describe Calculator::TotalPrice do
    let(:calculator) { described_class.new }

    describe '#call' do
        subject { calculator.call }

        let(:total_price) { 4000 }

        before do
            calculator.add_to_total_price(total_price)    
        end

        it 'calculates the price for products' do
            expect(subject).to eq 4000
        end
        
        context 'when rule present' do
            let(:rule) { { type: 'total_price_drop', total_price_required: 6000, drop_percentage: 10 } }
            let(:total_price) { 6010 }

            before { calculator.set_rules([rule]) }

            it 'calculates the price for products' do
                expect(subject).to eq 5409
            end
        end
    end
end