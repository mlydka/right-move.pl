require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Offer, 'new' do 
  it 'should be inactive by default' do
    offer = Offer.new
    offer.status.should be_false
  end

  it 'should accept status' do
    offer = Offer.new({:status => true})
    offer.status.should be_true
  end

  it 'should build address' do
    offer = Offer.new
    offer.should_receive(:build_address)
    offer.address_attributes = {:firstname => 'Tom'}
  end
end

describe Offer, 'create' do
  fixtures :variables

  it "should create valid object" do
    lambda do
      o = Offer.create({:category_id => 1, :type_id => 1, :code => '1234', :description => 'ęółśążźćń'})
      o.status.should be_false
      o.category_id.should == 1
      o.type_id.should == 1
      o.description.should == 'ęółśążźćń'
    end.should change(Offer, :count).by(1)
  end

  it "should create address" do
    lambda do
      Offer.create({:category_id => 1, :type_id => 1, :code => '1234', :address_attributes => { :street => 'Długa', :apartment => '23', :phone => '12 5432345' }})
    end.should change(Address, :count).by(1)
  end

  it "should create offers_variables" do
    lambda do
      Offer.create({:category_id => 1, :type_id => 1, :code => '1234', :address_attributes => {:street => 'Długa', :apartment => '23', :phone => '12 5432345'},
                                                                       :offers_variable_attributes => [{:value => '12', :variable_id => variables(:price).id}]})
    end.should change(OffersVariable, :count).by(1)
  end

  describe 'with images' do
    fixtures :images

    before(:each) do
      @parameters = {:category_id => 1, :type_id => 1, :code => '1234', :serial => 'cd08ca54bc270d3b',
                     :address_attributes => { :street => 'Długa', :apartment => '23', :phone => '12 5432345' } }
    end

    it 'should attach images' do
      offer = Offer.create(@parameters)
      offer.images.should_not be_empty
      offer.images.should == [images(:uploaded_image)]
    end

    it 'should reset attached image serial' do
      Offer.create(@parameters)
      images(:uploaded_image).serial.should be_nil
    end

    it 'should not change images count' do
      lambda do
        Offer.create(@parameters)
      end.should_not change(Image, :count)
    end
  end
end

describe Offer, 'being created' do
    fixtures :offers 

    it 'requires category_id' do
      lambda do
        o = Offer.create(:category_id => nil)
        o.errors.on(:category_id).should_not be_nil
      end.should_not change(Offer, :count)
    end

    it 'requires type_id' do
      lambda do
        o = Offer.create(:type_id => nil)
        o.errors.on(:type_id).should_not be_nil
      end.should_not change(Offer, :count)
    end

    it 'should not require description' do
      lambda do
        o = Offer.create(:category_id => 1, :type_id => 1, :description => nil, :code => '1234')
        o.errors.on(:description).should be_nil
      end.should change(Offer, :count).by(1)
    end
    
    it 'requires code' do
      lambda do
        o = Offer.create(:code => nil)
        o.errors.on(:code).should_not be_nil
      end.should_not change(Offer, :count)
    end

    it 'validate code' do
      lambda do
        o = Offer.create(:code => 'qwerty')
        o.errors.on(:code).should_not be_nil
      end.should_not change(Offer, :count)
    end

    it 'validate uniqueness_of of code' do
      lambda do
        o = Offer.create(:code => offers(:flat).code)
        o.errors.on(:code).should_not be_nil
      end.should_not change(Offer, :count)
    end
end

describe Offer, 'destroy' do
  fixtures :offers, :addresses, :images, :variables, :offers_variables

  it "should destroy its address as well" do
    lambda do 
      offers(:flat).destroy
    end.should change(Address, :count).by(-1)
  end

  it "should destroy its images as well" do
    lambda do 
      offers(:flat).destroy
    end.should change(Image, :count).by(-(offers(:flat).images.size + 1))
  end
  
  it "should destroy its offers_variables as well" do
    lambda do 
      offers(:flat).destroy
    end.should change(OffersVariable, :count).by(-offers(:flat).variables.size)
  end
end

describe Offer, 'update' do
  fixtures :offers, :addresses, :images, :variables, :offers_variables

  before(:each) do
    @offer = offers(:flat)
    @address = @offer.address
  end

  it "should update attributes" do
    @offer.update_attributes({ :category_id => 1, :description => 'Test', :status => false, :code => '1111'})
    @offer.category_id.should == 1
    @offer.status.should be_false
    @offer.description.should == 'Test'
    @offer.code.should == '1111'
  end

  it "should update address" do
    @address.should_receive(:update_attributes).with({:firstname => 'Tomek'}).and_return(true)
    @offer.update_attributes({:status => false, :address_attributes => { :firstname => 'Tomek' }})
  end
  
  it "should update offers_variable" do
    lambda do
      @offer.update_attributes({:offers_variable_attributes => [{:value => '666', :variable_id => variables(:price).id}]})
    end.should_not change(OffersVariable, :count).by(1)
    @offer.offers_variables.find_by_variable_id(variables(:price).id).value.should == '666'
  end

  it "should increment offers_variables count" do
    lambda do
      @offer.update_attributes({:offers_variable_attributes => [{:value => '12', :variable_id => variables(:price).id}, {:value => '2', :variable_id => variables(:floor).id}]})
    end.should change(OffersVariable, :count).by(1)
  end

  it "should decrement offers_variables count" do
    lambda do
      @offer.update_attributes({:offers_variable_attributes => []})
    end.should change(OffersVariable, :count).by(-1)
  end
end

describe Offer, "apply_variables_from_category" do
  fixtures :offers, :offers_variables, :categories, :variables

  it "should add missing variable" do
    @offer = offers(:flat)

    lambda do
      @offer.apply_variables_from_category
      @offer.offers_variables.size.should == @offer.category.variables.count
    end.should change( @offer.offers_variables, :size)
  end

end