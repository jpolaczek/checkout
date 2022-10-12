class Scanner
    def initialize
        @scanned_items = {}
    end

    def scan_item(item)
        scanned_items[item[:id]] = (scanned_items[item[:id]] || 0) + 1
    end

    attr_reader :scanned_items

    private

    attr_writer :scanned_items
end