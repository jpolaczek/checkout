require "#{$root}/src/checkout"
require "#{$root}/src/printer"

RSpec.describe Checkout do
    let(:checkout) { described_class.new( printer: printer) }
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
    end

    describe '#scan' do

    end
end