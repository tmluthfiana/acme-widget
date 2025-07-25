class ProductCatalogue
  Product = Struct.new(:code, :name, :price)

  def initialize(products)
    @products = {}
    products.each do |product|
      @products[product[:code]] = Product.new(product[:code], product[:name], product[:price])
    end
  end

  def find(code)
    @products[code]
  end
end 