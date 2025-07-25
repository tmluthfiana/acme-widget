class Offer
  # Subclasses should implement this method
  # items: array of product codes
  # catalogue: ProductCatalogue instance
  def apply(items, catalogue)
    raise NotImplementedError
  end
end 