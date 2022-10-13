require 'money'

class Printer
    BASKET_HEADLINE = 'Basket: '
    CURRENCY = 'GBP'
    TOTAL_PRICE = 'Total price expected: '
    COMMA = ', '

    private_constant :BASKET_HEADLINE, :CURRENCY, :TOTAL_PRICE, :COMMA
    class << self
        def print_basket_headline
            print BASKET_HEADLINE
        end

        def print_item(print_item, item_count)
            (item_count).times { print print_item.to_s + COMMA }
        end

        def print_total(total_price)
            puts ''
            puts (TOTAL_PRICE + Money.from_cents(total_price, CURRENCY).format)
        end
    end    
end