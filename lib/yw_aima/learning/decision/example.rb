class YW_AIMA::Learning::Decision::Example

  def initialize(attributes,decision=nil)
    @attributes,@decision = attributes,decision
  end

  def decided?
    !decision.nil?
  end

  attr_reader :attributes,:decision


end