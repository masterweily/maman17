$: << 'lib'
$: << '.'
require 'yw_aima'
require 'awesome_print'

module App
  extend ActiveSupport::Autoload

  autoload :Data
  Learner = YW_AIMA::Learning::Decision::Learner

  def self.run
    examples = Data.examples
    tree = Learner.tree_learn(examples)

    ap tree.to_hash
    #puts tree.to_hash.to_yaml

  end
end




