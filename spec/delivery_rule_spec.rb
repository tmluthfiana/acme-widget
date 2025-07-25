require 'rspec'
require_relative '../lib/delivery_rule'

describe DeliveryRule do
  let(:rules) do
    [
      { threshold: 50.0, cost: 4.95 },
      { threshold: 90.0, cost: 2.95 }
    ]
  end
  let(:delivery_rule) { DeliveryRule.new(rules) }

  it 'applies highest delivery cost for low total' do
    expect(delivery_rule.delivery_cost(10)).to eq(4.95)
  end

  it 'applies lower delivery cost for mid total' do
    expect(delivery_rule.delivery_cost(60)).to eq(2.95)
  end

  it 'applies free delivery for high total' do
    expect(delivery_rule.delivery_cost(100)).to eq(0.0)
  end
end 