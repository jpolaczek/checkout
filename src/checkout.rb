class Checkout
    ITEMS = [
        { 1 => 925 },
        { 2 => 4500 },
        { 3 => 1995 }
    ]

    private_constant :ITEMS

    def initialize(scanner: Scanner.new, printer: Printer.new)
        @scanner = scanner
        @printer = printer
    end

    def scan(item)
        scanner.scan_item(item)
    end

    def total
        total_price = 0
        printer.print_basket_headline

        scanner.scanned_items.each do |id, item_count|
            total_price = total_price + ITEMS[id] * item_count
            printer.print_item(id)
        end
        printer.print_total(total_price)
    end

    private 
    
    attr_reader :scanner, :printer
end