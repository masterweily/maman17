require 'rspec'
require './app'
module App

  describe Data do

    context 'examples' do
      let(:examples) { Data.examples }

      it 'should have examples' do
        examples.empty?.should be_false
      end

      it 's all examples must be decided' do
        examples.each do |example|
          example.decided?.should be_true
        end
      end

      it 's all examples must have attributs' do
        examples.each do |example|
          example.attributes.is_a?(Hash).should be_true
        end
      end
    end

  end

end