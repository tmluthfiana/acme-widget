require_relative '../offer'

class BuyThreeGetOneFree < Offer
  def initialize(product_code, required_qty = 3, free_qty = 1)
    @product_code = product_code
    @required_qty = required_qty
    @free_qty = free_qty
  end

  def apply(items, catalogue)
    count = items.count { |code| code == @product_code }
    return 0 if count < (@required_qty + @free_qty)
    product = catalogue.find(@product_code)
    eligible_sets = count / (@required_qty + @free_qty)
    discount = eligible_sets * product.price * @free_qty
    discount.round(2)
  end
end 