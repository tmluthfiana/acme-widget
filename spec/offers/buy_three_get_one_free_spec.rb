require 'rspec'
require_relative '../../lib/product_catalogue'
require_relative '../../lib/offers/buy_three_get_one_free'

describe BuyThreeGetOneFree do
  let(:products) { [ { code: 'B01', name: 'Blue Widget', price: 7.95 } ] }
  let(:catalogue) { ProductCatalogue.new(products) }
  let(:offer) { BuyThreeGetOneFree.new('B01') }

  it 'gives no discount for less than 4 items' do
    expect(offer.apply(['B01', 'B01', 'B01'], catalogue)).to eq(0)
  end

  it 'gives one free for 4 items' do
    expect(offer.apply(['B01', 'B01', 'B01', 'B01'], catalogue)).to eq(7.95)
  end

  it 'gives two free for 8 items' do
    expect(offer.apply(['B01'] * 8, catalogue)).to eq(15.90)
  end

  it 'gives one free for 5 items' do
    expect(offer.apply(['B01', 'B01', 'B01', 'B01', 'B01'], catalogue)).to eq(7.95)
  end
end 