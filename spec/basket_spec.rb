require 'rspec'
require_relative '../lib/basket'
require_relative '../lib/product_catalogue'
require_relative '../lib/delivery_rule'
require_relative '../lib/offers/buy_one_get_one_half_price'
require_relative '../lib/offers/buy_three_get_one_free'

RSpec.describe Basket do
  let(:products) do
    [
      { code: 'R01', name: 'Red Widget', price: 32.95 },
      { code: 'G01', name: 'Green Widget', price: 24.95 },
      { code: 'B01', name: 'Blue Widget', price: 7.95 }
    ]
  end
  let(:catalogue) { ProductCatalogue.new(products) }
  let(:delivery_rule) do
    DeliveryRule.new([
      { threshold: 50.0, cost: 4.95 },
      { threshold: 90.0, cost: 2.95 }
    ])
  end
  let(:offer) { BuyOneGetOneHalfPrice.new('R01') }

  def basket_with(*codes)
    basket = Basket.new(catalogue: catalogue, delivery_rule: delivery_rule, offers: [offer])
    codes.each { |code| basket.add(code) }
    basket
  end

  it 'calculates total for B01, G01' do
    expect(basket_with('B01', 'G01').total).to eq(37.85)
  end

  it 'calculates total for R01, R01' do
    expect(basket_with('R01', 'R01').total).to eq(54.37)
  end

  it 'calculates total for R01, G01' do
    expect(basket_with('R01', 'G01').total).to eq(60.85)
  end

  it 'calculates total for B01, B01, R01, R01, R01' do
    expect(basket_with('B01', 'B01', 'R01', 'R01', 'R01').total).to eq(98.27)
  end

  it 'returns 0.0 for an empty basket' do
    basket = Basket.new(catalogue: catalogue, delivery_rule: delivery_rule, offers: [offer])
    expect(basket.total).to eq(4.95)
  end

  it 'calculates total for a single B01 (below delivery threshold)' do
    expect(basket_with('B01').total).to eq(12.90)
  end

  it 'calculates total for a single R01 (below delivery threshold)' do
    expect(basket_with('R01').total).to eq(37.90)
  end

  it 'calculates total for three R01 (odd number, only one pair discounted)' do
    expect(basket_with('R01', 'R01', 'R01').total).to eq(85.32)
  end

  it 'raises error for invalid product code' do
    basket = Basket.new(catalogue: catalogue, delivery_rule: delivery_rule, offers: [offer])
    expect { basket.add('X99') }.to raise_error(/Unknown product code/)
  end

  it 'calculates total for 10 R01 (multiple pairs discounted)' do
    expect(basket_with(*(['R01'] * 10)).total).to eq(247.12)
  end

  it 'applies correct delivery fee at $50 threshold (just below)' do
    # 2x G01 = $49.90 + $4.95 delivery
    expect(basket_with('G01', 'G01').total).to eq(54.85)
  end

  it 'applies correct delivery fee at $50 threshold (just above)' do
    # 2x G01 + B01 = $57.85 + $2.95 delivery
    expect(basket_with('G01', 'G01', 'B01').total).to eq(60.80)
  end

  it 'applies correct delivery fee at $90 threshold (just below)' do
    # 4x R01 = $131.80, offer: 2 pairs = $32.95 discount, subtotal = $98.85, free delivery
    expect(basket_with('R01', 'R01', 'R01', 'R01').total).to eq(98.85)
  end

  it 'applies both red widget and blue widget offers together' do
    # 4x B01 (one free), 2x R01 (one half price)
    basket = Basket.new(
      catalogue: catalogue,
      delivery_rule: delivery_rule,
      offers: [BuyOneGetOneHalfPrice.new('R01'), BuyThreeGetOneFree.new('B01')]
    )
    ['B01', 'B01', 'B01', 'B01', 'R01', 'R01'].each { |code| basket.add(code) }
    # B01: 4x7.95 = 31.80, 1 free = 7.95 off, so 23.85
    # R01: 32.95 + 16.48 = 49.43
    # Subtotal: 23.85 + 49.43 = 73.28
    # Delivery: 2.95 (under $90)
    # Total: 76.23
    expect(basket.total).to eq(76.22)
  end
end 