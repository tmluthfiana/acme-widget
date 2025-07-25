require 'rspec'
require_relative '../../lib/product_catalogue'
require_relative '../../lib/offers/buy_one_get_one_half_price'

describe BuyOneGetOneHalfPrice do
  let(:products) { [ { code: 'R01', name: 'Red Widget', price: 32.95 } ] }
  let(:catalogue) { ProductCatalogue.new(products) }
  let(:offer) { BuyOneGetOneHalfPrice.new('R01') }

  it 'gives no discount for 1 item' do
    expect(offer.apply(['R01'], catalogue)).to eq(0)
  end

  it 'gives half price for second item' do
    expect(offer.apply(['R01', 'R01'], catalogue)).to eq(16.48)
  end

  it 'gives half price for every second item' do
    expect(offer.apply(['R01', 'R01', 'R01', 'R01'], catalogue)).to eq(32.95)
  end

  it 'gives half price for only one in odd count' do
    expect(offer.apply(['R01', 'R01', 'R01'], catalogue)).to eq(16.48)
  end
end 