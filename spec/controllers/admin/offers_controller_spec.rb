require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::OffersController, 'index' do
  describe "when user not logged in" do
    it "should be redirected" do
      get :index
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

  describe "when user logged in" do
    fixtures :offers

    before(:each) do
      login_as 'user'
      Offer.stub!(:find).and_return([offers(:flat)])
      Offer.should_receive(:find).with(:all, {:include=>:address})
      get :index
    end

    it "should be successful" do
      response.should be_success
    end

    it "should render 'index' template" do
      response.layout.should == 'layouts/admin/administration'
      response.should render_template('index')
    end

    it "should get offers" do
      assigns[:offers].should_not be_empty
    end
  end
end

describe Admin::OffersController, 'new' do
  describe "when user not logged in" do
    it "should be redirected" do
      get :new
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

  describe "when user logged in" do
    before(:each) do
      login_as 'user'
      get :new
    end

    it "should be successful" do
      response.should be_success
    end

    it "should render 'new' template" do
      response.layout.should == 'layouts/admin/administration'
      response.should render_template('new')
    end
    
    it "should create new instance variables" do
      assigns[:offer].should be_new_record
      assigns[:offer].address.should == assigns[:address]
      assigns[:address].should be_new_record
    end

    it "should assign serial" do
      assigns[:offer].serial.should_not be_nil
    end
  end
end

describe Admin::OffersController, "upload_image" do
  describe "when user not logged in" do
    it "should be redirected" do
      post :upload_image
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end
   
  describe "on create" do 
    before(:each) do
      login_as 'user'
      @image = Image.new(:serial => 'qwerty')
    end

    it "should render nothing when image is missed" do
      post :upload_image
      response.should be_success
      response.layout.should == nil
      response.should render_nothing
    end

    it "should render nothing on faild save" do
      Image.should_receive(:new).and_return(@image)
      @image.should_receive(:valid?).and_return(false)  
      post :upload_image, :image => {:uploaded_data => fixture_file_upload('files/image.jpg', 'image/jpg'), :serial => 'qwerty'}  
      assigns[:image].should be_new_record
      response.should render_nothing
    end

    it "should increment images count" do
      lambda do
        post :upload_image, :image => {:uploaded_data => fixture_file_upload('files/image.jpg', 'image/jpg'), :serial => 'qwerty'} 
      end.should change(Image, :count).by(2)
      assigns[:image].should_not be_new_record
      assigns[:image].serial.should == 'qwerty'
      assigns[:image].filename.should == 'image.jpg'
    end
  end

  describe "on update" do
    fixtures :offers      

    before(:each) do
      login_as 'user'
      @offer = offers(:flat)
      @image = @offer.images.build
    end

    it "should increment images count" do
      lambda do
        post :upload_image, :image => {:uploaded_data => fixture_file_upload('/files/image.jpg', 'image/jpg'), :offer_id => @offer.id} 
      end.should change(Image, :count).by(2)
      assigns[:image].should_not be_new_record
      assigns[:image].offer.should == @offer
      assigns[:image].filename.should == 'image.jpg'
    end

    it "should increment offer images count" do
      lambda do
        post :upload_image, :image => {:uploaded_data => fixture_file_upload('/files/image.jpg', 'image/jpg'), :offer_id => @offer.id}
      end.should change(@offer.images, :count).by(1)
    end
  end
end

describe Admin::OffersController, "destroy_image" do
  fixtures :images

  describe "when user not logged in" do
    it "should be redirected" do
      post :destroy_image
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

  describe "when user logged in" do
    before(:each) do
      login_as 'user'
      @image = images(:image)
    end   
    
    it "should render nothing on faild destroy" do
      Image.should_receive(:find).and_return(@image)
      @image.should_receive(:destroy).and_return(false)
      delete :destroy_image, :image_id => @image.id
      response.should be_success
      response.layout.should == nil
      response.should render_nothing
    end

    it "should decrement images count" do
      lambda do
        delete :destroy_image, :image_id => @image.id
      end.should change(Image, :count).by(-2)
      assigns[:image].should_not be_nil
      response.should have_rjs(:remove, "image_#{@image.id}")
    end
  end
end

describe Admin::OffersController, "create" do
  fixtures :variables, :images

  describe "when user not logged in" do
    it "should be redirected" do
      post :create
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

 describe "when user logged in" do
    before(:each) do
      login_as 'user'
      @offer = Offer.new
      @address = @offer.build_address
    end   

    it "should redirect to offers path with a notice on successful offer save" do
      Offer.should_receive(:new).and_return(@offer)
      @offer.should_receive(:valid?).and_return(true)
      post :create, :offer => {}
      assigns[:offer].should_not be_new_record
      flash[:notice].should_not be_nil
      response.should redirect_to(admin_offers_path)
    end
    
    it "should re-render new template on failed offer save" do
      Offer.should_receive(:new).and_return(@offer)
      @offer.should_receive(:valid?).and_return(false)
      @offer.should_receive(:address).and_return(@address)
      post :create, :offer => {}
      assigns[:offer].should be_new_record
      assigns[:address].should be_new_record
      flash[:notice].should be_nil
      response.should render_template('new')
    end

    it "should pass params to assigned instance variables" do
      params = {'category_id' => '1', 'type_id' => '1', 'status' => false, 'code' => '1234', 'description' => 'Test', 'address_attributes' => {}}
      Offer.should_receive(:new).with(params).and_return(@offer)
      post :create, :offer => params
      assigns[:offer].category_id.should == params[:category_id]
      assigns[:offer].type_id.should == params[:type_id]
      assigns[:offer].description.should == params[:description]
      assigns[:offer].code.should == params[:code]
    end

    it "should create offers_variable" do
      params = {'category_id' => '1', :type_id => 1, 'code' => '1234', 'address_attributes' => {:street => 'Długa', :apartment => '23', :phone => '12 5432345' },
                                                                      'offers_variable_attributes' => [{'value' => '12', 'variable_id' => variables(:price).id}]}
      lambda do
        post :create, :offer => params
      end.should change(OffersVariable, :count).by(1)
      assigns[:offer].offers_variables.find_by_variable_id(variables(:price).id).should_not be_nil
    end

    it "should attach images" do
      params = {'category_id' => '1', 'type_id' => 1, 'code' => '1234', :serial => 'cd08ca54bc270d3b',
                                                     'address_attributes' => {:street => 'Długa', :apartment => '23', :phone => '12 5432345' },
                                                     'offers_variable_attributes' => [{'value' => '12', 'variable_id' => variables(:price).id}]}
     
      post :create, :offer => params
      assigns[:offer].images.should_not be_empty
      assigns[:offer].images.should == [images(:uploaded_image)]
    end
  end
end

describe Admin::OffersController, 'edit' do
  describe "when user not logged in" do
    it "should be redirected" do
      get :edit
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

  describe "when user logged in" do
    fixtures :offers, :addresses, :images
    
    before(:each) do
      login_as 'user'
      @offer = offers(:flat)
      Offer.should_receive(:find).with(@offer.id.to_s, {:include=>[:address, :offers_variables, :images]}).and_return(@offer)
    end
    
    it "should apply variables from category" do
      @offer.should_receive(:apply_variables_from_category)
      get :edit, :id => @offer.id
    end

    it "should be successful and render 'edit' template" do
      get :edit, :id => @offer.id

      response.should be_success
      response.layout.should == 'layouts/admin/administration'
      response.should render_template('edit')
    end
    
    it "should set instance variables" do
      get :edit, :id => @offer.id
      assigns[:offer].should_not be_nil
      assigns[:address].should_not be_nil
    end
        
    it "should not apply serial" do
      get :edit, :id => @offer.id
      assigns[:offer].serial.should be_nil
      assigns[:offer].images.should_not be_empty
    end
  end
end

describe Admin::OffersController, "update" do
  describe "when user not logged in" do
    it "should be redirected" do
      put :update
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

 describe "when user logged in" do
   fixtures :offers, :addresses, :categories, :types

    before(:each) do
      login_as 'user'
      @offer = offers(:flat) 
      @address = @offer.address
    end   

    it "should redirect to offers path with a notice on successful offer save" do
      Offer.should_receive(:find).and_return(@offer)
      @offer.should_receive(:valid?).and_return(true)
      put :update, :id => @offer.id, :offer => {}
      assigns[:offer].should_not be_nil
      flash[:notice].should_not be_nil
      response.should redirect_to(admin_offers_path)
    end

    it "should re-render edit template on failed offer update" do
      Offer.should_receive(:find).and_return(@offer)
      @offer.should_receive(:valid?).and_return(false)
      put :update, :id => @offer.id, :offer => {}
      assigns[:offer].should_not be_nil
      assigns[:address].should_not be_nil
      flash[:notice].should be_nil
      response.should render_template('edit')
    end

    it "should re-render edit template on failed address update" do
      Offer.should_receive(:find).and_return(@offer)
      put :update, :id => @offer.id, :offer => {:category_id => 1, :type_id => 1, :address_attributes => { :phone => nil }}
      assigns[:offer].should_not be_nil
      assigns[:address].should_not be_nil
      flash[:notice].should be_nil
      response.should render_template('edit')
    end
    
    it "should pass params to assigned instance variables" do
      Offer.should_receive(:find).and_return(@offer)
      put :update, :id => @offer.id, :offer => {:category_id => categories(:apartments).id, :type_id => types(:rent).id, :status => false, :description => 'Test',
                                                :address_attributes => { :phone => '111 11 11' }}
      assigns[:offer].status.should be_false
      assigns[:offer].category.should == categories(:oneroom_apartments)
      assigns[:offer].type.should == types(:rent)
      assigns[:offer].description.should == 'Test'

      assigns[:offer].address.phone.should == '111 11 11'
    end

    it "should not update category" do
      Offer.should_receive(:find).and_return(@offer)
      put :update, :id => @offer.id, :offer => {:category_id => 1, :type_id => types(:sale).id, :status => false, :address_attributes => { :phone => '111 11 11' }}
      assigns[:offer].category_id.should == categories(:oneroom_apartments).id
    end
  end
end

describe Admin::OffersController, "destroy" do
  fixtures :offers, :addresses

  describe "when user not logged in" do
    it "should be redirected" do
      delete :destroy, :id => offers(:flat)
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

  describe "when user logged in" do
    before(:each) do
      login_as 'user'
    end

    it "should decrement Offers count" do
      lambda do
        delete :destroy, :id => offers(:flat)
      end.should change(Offer, :count).by(-1)
    end

    it "should decrement Addresses count" do
      lambda do
        delete :destroy, :id => offers(:flat)
      end.should change(Address, :count).by(-1)
    end

    it "should decrement Images count" do
      lambda do
        delete :destroy, :id => offers(:flat)
      end.should change(Image, :count).by(-2)
    end

    it "should be redirected with a notice on successful delete" do
      delete :destroy, :id => offers(:flat)
      response.should be_redirect
      response.should redirect_to(admin_offers_path)
      flash[:notice].should_not be_nil
    end
  end
end

describe Admin::OffersController, "toggle_variables_form" do
  fixtures :categories, :variables

  describe "when user not logged in" do
    it "should be redirected" do
      xhr :post, :toggle_variables_form, :category_id => categories(:apartments).id
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

  describe "when user logged in" do
    before(:each) do
      login_as 'user'
      @offer = Offer.new
      @category = categories(:apartments)
    end

    it "should accept only ajax calls" do
      post :toggle_variables_form, :category_id => @category.id
      response.code.should eql("404")
    end

    it "should render nothing when category is missed" do
      xhr :post, :toggle_variables_form, :category_id => nil
      response.should be_success
      response.layout.should == nil
      response.should render_nothing
    end

    it "should render partial with category variable inputs" do
      Offer.should_receive(:new).and_return(@offer)
      Category.should_receive(:find).with(@category.id.to_s, {:include => :variables}).and_return(@category)
      controller.should_receive(:render).with hash_including(:partial => 'form_variable', :collection => @offer.offers_variables)
      xhr :post, :toggle_variables_form, :category_id => @category.id
    end

    it "should replace #variables div content" do
      Offer.should_receive(:new).and_return(@offer)
      Category.should_receive(:find).with(@category.id.to_s, {:include => :variables}).and_return(@category)
      xhr :post, :toggle_variables_form, :category_id => @category.id
    end
  end
end


