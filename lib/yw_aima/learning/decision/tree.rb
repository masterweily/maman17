require 'json'
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

  def to_hash
    if leaf?
      @value
    else
      attribute = @value
      branches = {}
      @branches.each do |k,v|
        branches[k] = v.to_hash
      end
      return { attribute => branches }
    end
    #hash = { value: @value, branches: {}}
    #@branches.each do |k,v|
    #  hash[:branches][k] = v.to_hash
    #end
    #return hash

  end

  def to_s
    to_hash.to_s
  end

  def to_json
    to_hash.to_json
  end


end