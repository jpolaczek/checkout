$root = Dir.pwd

require "#{$root}/src/checkout"
require 'money'
Money.locale_backend = nil

items = [
    { id: 1 },
    { id: 2 },
    { id: 3 }
]

rules = [
    { type: 'total_price_drop', total_price_required: 6000, drop_percentage: 10 },
    { type: 'new_item_price', required_bought_items: 2, new_price: 850, id: 1 }
]

checkout = Checkout.new(rules)

checkout.scan(items[0])
checkout.scan(items[1])
checkout.scan(items[2])

checkout.total

checkout = Checkout.new(rules)

checkout.scan(items[0])
checkout.scan(items[2])
checkout.scan(items[0])
checkout.total

checkout = Checkout.new(rules)

checkout.scan(items[0])
checkout.scan(items[1])
checkout.scan(items[0])
checkout.scan(items[2])
checkout.total
