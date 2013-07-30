require 'rspec'
require 'yw_aima'
require './app'
module YW_AIMA
  module Learning
    module Decision

      describe Learner do
        let(:examples) { App::Data.test_examples }

        context 'tree_learn' do

          let(:tree) { Learner.tree_learn(examples) }

          it 's result must be tree' do
            tree.is_a?(Tree).should be_true
          end

          it 's result tree must be consistent with the examples' do
            examples.each do |example|
              tree.classify(example).should == example.decision
            end
          end

        end

        context 'private methods' do

          let(:attributes) { Learner.extract_attributes examples }

          it 'will find values for attributes' do
            Learner.values_for('Outlook',examples).same_values?(%w(Sunny Overcast Rain)).should be_true
          end

          it 'will extract attributes from example' do
            attributes.same_values?(%w(Outlook Temperature Humidity Wind)).should be_true
          end

          it 'will find plurality value' do
            Learner.plurality_value(examples).should == 'Yes'
            Learner.plurality_value(examples.take(1)).should == 'No'
          end

          it 'will tie break randomly in plurality value' do
            (1..100).map{ Learner.plurality_value(examples.take(4)) }.uniq.size.should be 2
          end

          it 'will calculate gain' do
            Learner.gain('Wind',examples).should be_within(0.001).of(0.048)
          end

          it 'will calculate probabilities' do
            Learner.probability('Yes',examples).should ==  9.0 / 14
          end
          it 'will calculate entropy' do
            Learner.entropy(examples).should be_within(0.001).of(0.94)
          end

          it 'will choose the most important attribute' do
            chosen = Learner.choose_attribute(attributes,examples)
            attributes.each do |attribute|
              Learner.importance(attribute,examples).should <= Learner.importance(chosen,examples)
            end
          end


        end

      end

    end
  end
end


class Array
  def same_values? other
    self.sort == other.sort
  rescue
    self.sort_by(&:to_s) == other.sort_by(&:to_s)
  end
end