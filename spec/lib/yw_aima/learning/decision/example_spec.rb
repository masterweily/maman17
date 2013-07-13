require 'rspec'
require 'yw_aima'
module YW_AIMA::Learning::Decision


  describe Example do

    attributes = {
        'Favorite Beer' => false,
        'VIP' => false,
        'Location' => 'Rotchild blvd.'
    }

    decision = false
    let(:example) { Example.new attributes,decision  }
    let(:undecided) { Example.new attributes }

    it 'should have attributes' do

      example.attributes.should == attributes

    end

    context 'when created with decision' do
      it 'should have decision' do
        example.decision.should == decision
      end

      it 'sould be decided' do
        example.decided?.should be_true
      end

    end

    context 'when created without decision' do

      it 'should not have decision' do
        undecided.decision.should be_nil
      end

      it 'sould not be decided' do
        undecided.decided?.should be_false
      end

    end

  end
end