require "#{$root}/src/printer"
require 'money'

Money.locale_backend = nil

RSpec.describe Printer do
    describe '.print_basket_headline' do
        subject { described_class.print_basket_headline }

        it 'prints headline' do
            expect { subject }.to output('Basket: ').to_stdout
        end
    end

    describe '.print_item' do
        subject { described_class.print_item(item_id, item_count) }

        let(:item_id) { 1 }
        let(:item_count) { 1 }

        it 'prints item' do
            expect { subject }.to output('1, ').to_stdout
        end

        describe 'when many items' do
            subject { described_class.print_item(item_id, item_count) }

            let(:item_count) { 2 }

            it 'prints many items' do
                expect { subject }.to output('1, 1, ').to_stdout
            end
        end
    end

    describe '.print_total' do
        subject { described_class.print_total(112) }

        it 'prints total price' do
            expect{subject}.to output("\nTotal price expected: £1.12\n").to_stdout
        end
    end
end