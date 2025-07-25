require_relative '../offer'

class BuyOneGetOneHalfPrice < Offer
  def initialize(product_code)
    @product_code = product_code
  end

  def apply(items, catalogue)
    # Only apply to the specified product code
    count = items.count { |code| code == @product_code }
    return 0 if count < 2
    product = catalogue.find(@product_code)
    # For every pair, one is half price
    pairs = count / 2
    discount = pairs * (product.price / 2.0)
    discount.round(2)
  end
end 