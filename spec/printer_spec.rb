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
        subject { described_class.print_item(1) }

        it 'prints headline' do
            expect{subject}.to output('1, ').to_stdout
        end
    end

    describe '.print_total' do
        subject { described_class.print_total(112) }

        it 'prints total price' do
            expect{subject}.to output('Total price expected: £1.12').to_stdout
        end
    end
end