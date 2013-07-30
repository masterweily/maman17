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

    def self.gain attribute,examples
      entropy(examples) - values_for(attribute,examples).map { |value| reduced_entropy(attribute,value,examples) }.inject(:+)
    end

    def self.reduced_entropy attribute,value,examaples
      selected = examaples.select{|example| example.attributes[attribute] == value }
      selected.size.to_f / examaples.size * entropy(selected)
    end

    def self.entropy examples
      decisions(examples).map{
          |decision| probability(decision,examples)
      }.map {
          |p| - p * Math.log2(p)
      }.inject(&:+)
    end

    def self.probability(decision, examples)
      examples.select{|example| example.decision == decision}.size.to_f / examples.size
    end

    def self.values_for(attribute, examples)
      examples.map{ |e| e.attributes[attribute] }.uniq
    end


    def self.same_class(examples)
      decisions(examples).size == 1
    end

    def self.decisions(examples)
      examples.map(&:decision).uniq
    end

    def self.choose_attribute(attributes, examples)
      attributes.max_by{ |attribute| importance(attribute,examples) }
    end

    def self.importance(attribute, examples)
      #attribute.to_s.length
      gain(attribute,examples)
    end


    def self.plurality_value(examples)
      examples.map(&:decision).group_by{|x|x}.group_by{|k,v|v.size}.max.last.sample.first
    end

    def self.extract_attributes(examples)
      examples.first.attributes.keys
    end


  end
end