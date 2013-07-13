require 'rspec'
require 'yw_aima'
require './app'
module YW_AIMA
  module Learning
    module Decision

      describe Learner do
        let(:examples) { App::Data.examples }
        let(:learner) { Learner.new }


        context 'tree_learn' do

          let(:tree) { learner.tree_learn(examples) }

          it 's result must be tree' do
            tree.is_a?(Tree).should be_true
          end

          it 's result must be consistent with the examples' do
            examples.each do |example|
              tree.classify(example).should == example.decision
            end
          end

        end

      end

    end
  end
end