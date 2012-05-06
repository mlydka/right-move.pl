require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Variable do
 
  describe 'being created' do
    it 'requires name' do
      lambda do
        v = Variable.create(:name => nil)
        v.errors.on(:name).should_not be_nil
      end.should_not change(Variable, :count)
    end

    describe 'allows legitimate names:' do
      ['powierzchnia', 'ilość pokoi', 'cena', 'opis', 'cena za metr', 'wielkość'
      ].each do |name_str|
        it "'#{name_str}'" do
          lambda do
            v = Variable.create(:name => name_str)
            v.errors.on(:name).should be_nil
          end.should change(Variable, :count).by(1)
        end
      end
    end

    describe 'disallows illegitimate names' do
      ['23', '@pow', 'm2', '_cena', 'wiel-kość'
      ].each do |name_str|
        it "'#{name_str}'" do
          lambda do
            v = Variable.create(:name => name_str)
            v.errors.on(:name).should_not be_nil
          end.should_not change(Variable, :count)
        end
      end
    end
    
    it 'should create options' do
      lambda do
        Variable.create(:name => 'floor', :new_option_attributes => {{:name => 'first'}, {:name => 'second'}})
      end.should change(Option, :count).by(2)
    end
  end

  describe 'being updated' do
    fixtures :variables, :options

    it 'should update options' do
      lambda do
        variables(:floor).update_attributes(:new_option_attributes => [{:name => 'III'}], :existing_option_attributes => {options(:second_floor).id.to_s => {:name => 'II'}})
      end.should_not change(Option, :count)

       variables(:floor).options.collect(&:name).should eql(['II', 'III'])
    end
  
  end

  describe 'being deleted' do
    fixtures :variables, :options

    it 'should destroy its options as well' do
      lambda do
        variables(:floor).destroy
      end.should change(Option, :count).by(-2)
    end
  end

end
