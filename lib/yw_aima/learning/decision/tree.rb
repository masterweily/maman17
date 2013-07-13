class YW_AIMA::Learning::Decision::Tree

  def initialize(arg)
    if arg.is_a? Hash
      @leafs = arg
    else
      @decision = arg
    end
  end

  def decision(attributes)
    if leaf?
      @decision
    else
      evaluate_decision(attributes)
    end
  end
  alias_method :classify, :decision

  def leaf?
    !@decision.nil?
  end

  private
  def evaluate_decision(attributes)
    # TODO
  end


end