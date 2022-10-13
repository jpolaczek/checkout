require "#{$root}/src/checkout"
require "#{$root}/src/printer"

RSpec.describe Checkout do
    let(:checkout) { described_class.new(printer: printer) }
    let(:printer) { Printer }

    describe '#total' do
        subject { checkout.total }

        let(:items) do
            [
                { id: 1 },
                { id: 2 },
                { id: 3 }
            ]
        end
        let(:total_price) { 7420 }

        before { items.each { |item| checkout.scan(item)} }

        it 'prints total information', :aggregate_errors do
            expect(printer).to receive(:print_basket_headline).once
            expect(printer).to receive(:print_item).with(1, 1).once
            expect(printer).to receive(:print_item).with(2, 1).once
            expect(printer).to receive(:print_item).with(3, 1).once
            expect(printer).to receive(:print_total).with(total_price).once

            subject
        end

        context 'with multiple objects of the same id' do
            let(:items) do
                [
                    { id: 1 },
                    { id: 3 },
                    { id: 1 }
                ]
            end
            let(:total_price) { 3845 }


            it 'prints total information', :aggregate_errors do
                expect(printer).to receive(:print_basket_headline).once
                expect(printer).to receive(:print_item).with(1, 2).once
                expect(printer).to receive(:print_item).with(3, 1).once
                expect(printer).to receive(:print_total).with(total_price).once
    
                subject
            end
        end

        context 'when promotional rules applied' do
            let(:checkout) { described_class.new(promotional_rules, printer: printer) }

            let(:promotional_rules) do
                [
                    { type: 'total_price_drop', total_price_required: 6000, drop_percentage: 10 },
                    { type: 'new_item_price', required_bought_items: 2, new_price: 850, id: 1 }
                ]
            end

            context 'with price higher than 6000' do
                let(:items) do
                    [
                        { id: 1 },
                        { id: 2 },
                        { id: 3 }
                    ]
                end
                let(:total_price) { 6678 }
    
                it 'prints total information', :aggregate_errors do
                    expect(printer).to receive(:print_basket_headline).once
                    expect(printer).to receive(:print_item).with(1, 1).once
                    expect(printer).to receive(:print_item).with(2, 1).once
                    expect(printer).to receive(:print_item).with(3, 1).once
                    expect(printer).to receive(:print_total).with(total_price).once
        
                    subject
                end
            end

            context 'with single item promotion applied' do
                let(:items) do
                    [
                        { id: 1 },
                        { id: 1 },
                        { id: 3 }
                    ]
                end
                let(:total_price) { 3695 }
    
                it 'prints total information', :aggregate_errors do
                    expect(printer).to receive(:print_basket_headline).once
                    expect(printer).to receive(:print_item).with(1, 2).once
                    expect(printer).to receive(:print_item).with(3, 1).once
                    expect(printer).to receive(:print_total).with(total_price).once
        
                    subject
                end
            end

            context 'with both types of promotion appied' do
                let(:items) do
                    [
                        { id: 1 },
                        { id: 2 },
                        { id: 1 },
                        { id: 3 }
                    ]
                end
                let(:total_price) { 7376 }
    
                it 'prints total information', :aggregate_errors do
                    expect(printer).to receive(:print_basket_headline).once
                    expect(printer).to receive(:print_item).with(1, 2).once
                    expect(printer).to receive(:print_item).with(2, 1).once
                    expect(printer).to receive(:print_item).with(3, 1).once
                    expect(printer).to receive(:print_total).with(total_price).once
        
                    subject
                end
            end
        end
    end

    describe '#scan' do

    end
end