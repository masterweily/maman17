class YW_AIMA::Learning::Decision::Tree

  def initialize(value)
    @value = value
    @branches = {}
  end

  def decision(example)
    leaf? ? @value : @branches[example.attributes[@value]].decision(example)
  end
  alias_method :classify, :decision

  def add_branch(label,subtree)
    @branches[label] = subtree
  end

  def leaf?
    @branches.empty?
  end

end