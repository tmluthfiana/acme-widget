require 'rspec'
require_relative '../lib/product_catalogue'

describe ProductCatalogue do
  let(:products) do
    [
      { code: 'R01', name: 'Red Widget', price: 32.95 },
      { code: 'G01', name: 'Green Widget', price: 24.95 }
    ]
  end
  let(:catalogue) { ProductCatalogue.new(products) }

  it 'finds a product by code' do
    product = catalogue.find('R01')
    expect(product.name).to eq('Red Widget')
    expect(product.price).to eq(32.95)
  end

  it 'returns nil for unknown code' do
    expect(catalogue.find('X99')).to be_nil
  end
end 