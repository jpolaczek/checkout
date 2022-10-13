require "#{$root}/src/printer"
require "#{$root}/src/scanner"
require "#{$root}/src/calculator/item_price"
require "#{$root}/src/calculator/total_price"
require 'byebug'

class Checkout
    def initialize(promotional_rules = nil,
                    scanner: Scanner.new, 
                    printer: Printer,
                    item_price_calculator: Calculator::ItemPrice.new,
                    total_price_calculator: Calculator::TotalPrice.new)
        @scanner = scanner
        @printer = printer
        @item_price_calculator = item_price_calculator
        @total_price_calculator = total_price_calculator

        if promotional_rules
            item_price_calculator.set_rules(promotional_rules.select { |rule| rule[:id] }) 
            total_price_calculator.set_rules(promotional_rules.select { |rule| rule[:id].nil? })
        end
    end

    def scan(item)
        scanner.scan_item(item)
    end

    def total
        total_price = 0
        printer.print_basket_headline
        
        scanner.scanned_items.each do |id, item_count|
            item_price = item_price_calculator.call(item_id: id, item_count: item_count)
            total_price_calculator.add_to_total_price(item_price)

            printer.print_item(id, item_count)
        end
        printer.print_total(total_price_calculator.call)
    end

    private 
    
    attr_reader :scanner, :printer, :promotional_rules, :item_price_calculator, :total_price_calculator
end