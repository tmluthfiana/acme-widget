require_relative 'product_catalogue'
require_relative 'delivery_rule'
require_relative 'offer'

class Basket
  def initialize(catalogue:, delivery_rule:, offers: [])
    @catalogue = catalogue
    @delivery_rule = delivery_rule
    @offers = offers
    @items = []
  end

  def add(product_code)
    raise "Unknown product code: #{product_code}" unless @catalogue.find(product_code)
    @items << product_code
  end

  def total
    subtotal = @items.sum { |code| @catalogue.find(code).price }
    total_discount = @offers.sum { |offer| offer.apply(@items, @catalogue) }
    discounted_total = subtotal - total_discount
    delivery = @delivery_rule.delivery_cost(discounted_total)
    (discounted_total + delivery).round(2)
  end
end 