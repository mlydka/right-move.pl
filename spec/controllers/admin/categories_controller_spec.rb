require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::CategoriesController, "index" do
  describe "when user not logged in" do
    it "should be redirected" do
      get :index
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

  describe "when user logged in" do
    fixtures :categories

    before(:each) do
      login_as 'user'
      get :index
    end

    it "should be successful" do
      response.should be_success
    end

    it "should render 'index' template" do
      response.layout.should == 'layouts/admin/administration'
      response.should render_template('index')
    end

    it "should get categories" do
      assigns[:categories].should_not be_empty
      assigns[:categories].size.should == 3
    end
  end
end

describe Admin::CategoriesController, "new" do
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

    it "should create new category" do
      assigns[:category].should_not be_nil
      assigns[:category].should be_new_record
    end
  end
end

describe Admin::CategoriesController, "create" do
  fixtures :categories

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
    end

    it "should redirect to categories path with a notice on successful save" do
      Category.stub!(:valid?).and_return(true)
      post :create, :category => { :name => 'domy' }
      assigns[:category].should_not be_new_record
      flash[:notice].should_not be_nil
      response.should redirect_to(admin_categories_path)
    end

    it "should re-render new template on failed save" do
      Category.stub!(:valid?).and_return(false)
      post :create, :category => { :name => '' }
      assigns[:category].should be_new_record
      flash[:notice].should be_nil
      response.should render_template('new')
    end

    it "should pass params to category" do
      post :create, :category => { :name => 'domy' }
      assigns[:category].name.should == 'domy'
    end

    it "should increment Categories count" do
      lambda do
        post :create, :category => { :name => 'domy' }
      end.should change(Category, :count).by(1)
    end
    
    it "should assign parent category" do
      post :create, :category => { :name => 'domy', :parent_id => categories(:allotments).id }
      assigns[:category].name.should == 'domy'
      assigns[:category].parent == categories(:allotments)
    end
  end
end

describe Admin::CategoriesController, "edit" do
  describe "when user not logged in" do
    it "should be redirected" do
      get :edit
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

  describe "when user logged in" do
    fixtures :categories

    before(:each) do
      login_as 'user'
      get :edit, :id => categories(:apartments)
    end

    it "should be successful" do
      response.should be_success
    end

    it "should render 'new' template" do
      response.layout.should == 'layouts/admin/administration'
      response.should render_template('edit')
    end

    it "should assign category" do
      assigns[:category].should_not be_nil
    end
  end
end

describe Admin::CategoriesController, "update" do
  fixtures :categories

  describe "when user not logged in" do
    it "should be redirected" do
      put :update, :id => categories(:oneroom_apartments)
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

  describe "when user logged in" do
    before(:each) do
      login_as 'user'
    end

    it "should redirect to categories path with a notice on successful update" do
      Category.stub!(:valid?).and_return(true)
      put :update, :id => categories(:oneroom_apartments), :category => { :name => 'new name', :variable_ids => [] }
      assigns[:category].should_not be_nil
      flash[:notice].should_not be_nil
      response.should redirect_to(admin_categories_path)
    end

    it "should re-render edit template on failed update" do
      Category.stub!(:valid?).and_return(false)
      put :update, :id => categories(:oneroom_apartments), :category => { :name => '', :variable_ids => [] }
      assigns[:category].should_not be_nil
      flash[:notice].should be_nil
      response.should render_template('edit')
    end

    it "should pass params to category" do
      put :update, :id => categories(:oneroom_apartments), :category => { :name => 'new name', :variable_ids => [] }
      assigns[:category].name.should == 'new name'
      assigns[:category].variables.should be_empty
    end

    it "should detach parent" do
      put :update, :id => categories(:oneroom_apartments), :category => { :name => 'new name', :parent_id => '', :variable_ids => [] }
      assigns[:category].parent.should be_nil
    end

    it "should not increment Category count" do
      Category.stub!(:valid?).and_return(true)
      lambda do
        put :update, :id => categories(:oneroom_apartments), :category => { :name => 'new name', :variable_ids => [] }
      end.should_not change(Category, :count)
    end
  end
end

describe Admin::CategoriesController, "show" do
  fixtures :categories

  describe "when user not logged in" do
    it "should be redirected" do
      get :show
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

  describe "when user logged in" do
    before(:each) do
      login_as 'user'
      get :show, :id => categories(:allotments)
    end

    it "should be successful" do
      response.should be_success
    end

    it "should render 'show' template" do
      response.layout.should == 'layouts/admin/administration'
      response.should render_template('show')
    end

    it "should assign category" do
      assigns[:category].should_not be_nil
    end
  end
end

describe Admin::CategoriesController, "destroy" do
  fixtures :categories

  describe "when user not logged in" do
    it "should be redirected" do
      delete :destroy, :id => categories(:oneroom_apartments)
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

  describe "when user logged in" do
    before(:each) do
      login_as 'user'
    end

    it "should decrement Category count" do
      lambda do
        delete :destroy, :id => categories(:oneroom_apartments)
      end.should change(Category, :count).by(-1)
    end

    it "should be redirected with a notice on successful delete" do
      delete :destroy, :id => categories(:oneroom_apartments)
      response.should be_redirect
      response.should redirect_to(admin_categories_path)
      flash[:notice].should_not be_nil
    end
  end
end
