require "#{$root}/src/scanner"

RSpec.describe Scanner do
    let(:scanner) { Scanner.new }

    describe '#scan_item' do
        subject { scanner.scan_item({ id: 4 }) }

        it 'registers a new item', :aggregate_errors do
            expect(scanner.scanned_items).to eq({})
            subject
            expect(scanner.scanned_items).to eq({ 4 => 1 })
        end

        context 'when copy already present' do
            before { scanner.scan_item({ id: 4 }) }

            it 'registers a new item', :aggregate_errors do
                expect { subject }.to change { scanner.scanned_items }.from({ 4 => 1 }).to({ 4 => 2 })
            end 
        end
    end
end