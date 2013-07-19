module YW_AIMA::Learning::Decision
  module Learner

    # figure 18.5 implementation
    def self.tree_learn(examples, attributes=extract_attributes(examples), parent_examples=[])

      return Tree.new plurality_value(parent_examples)  if examples.empty?
      return Tree.new examples.first.decision           if same_class(examples)
      return Tree.new plurality_value(examples)         if attributes.empty?

      a = choose_attribute(attributes, examples)
      tree = Tree.new(a)

      values_for(a,examples).each do |value|
        exs = examples.select{ |e| e.attributes[a] == value }
        subtree = tree_learn(exs,attributes-[a],examples)
        tree.add_branch(value,subtree)
      end

      return tree

    end



    private
    def self.values_for(attribute, examples)
      examples.map{ |e| e.attributes[attribute] }.uniq
    end


    def self.same_class(examples)
      examples.uniq(&:decision).length == 1
    end

    def self.choose_attribute(attributes, examples)
      attributes.max_by{ |attribute| importance(attribute,examples) }
    end

    def self.importance(attribute, examples)
      # todo
      attribute.to_s.length
    end


    def self.plurality_value(examples)
      examples.map(&:decision).group_by{|x|x}.group_by{|k,v|v.size}.max.last.sample.first
    end

    def self.extract_attributes(examples)
      examples.first.attributes.keys
    end


  end
end