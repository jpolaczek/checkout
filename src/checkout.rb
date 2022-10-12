class Checkout
    ITEMS = [
        { id: 1, price: 925 },
        { id: 2, price: 4500 },
        { id: 3, price: 1995 }
    ]

    private_constant :ITEMS

    def scan(item)
        scanner.scan_item(item)
    end

    private

    def scanner
        @scanner ||= Scanner.new
    end
end