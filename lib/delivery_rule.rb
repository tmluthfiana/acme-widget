class DeliveryRule
  def initialize(rules)
    # rules: array of { threshold: Float, cost: Float }, sorted ascending by threshold
    @rules = rules.sort_by { |r| r[:threshold] }
  end

  def delivery_cost(total)
    @rules.each do |rule|
      return rule[:cost] if total < rule[:threshold]
    end
    0.0
  end
end 