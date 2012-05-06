require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::VariablesController, "index" do
  describe "when user not logged in" do
    it "should be redirected" do
      get :index
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

  describe "when user logged in" do
    fixtures :variables

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

    it "should get variables" do
      assigns[:variables].should_not be_empty
    end
  end
end

describe Admin::VariablesController, "new" do
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

    it "should create new variable" do
      assigns[:variable].should_not be_nil
      assigns[:variable].should be_new_record

      assigns[:variable].options.should be_empty
    end
  end
end

describe Admin::VariablesController, "create" do
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

    it "should redirect to variables path with a notice on successful save" do
      Variable.stub!(:valid?).and_return(true)
      post :create, :variable => { :name => 'cena' }
      assigns[:variable].should_not be_new_record
      flash[:notice].should_not be_nil
      response.should redirect_to(admin_variables_path)
    end

    it "should re-render new template on failed save" do
      Variable.stub!(:valid?).and_return(false)
      post :create, :variable => { :name => '' }
      assigns[:variable].should be_new_record
      flash[:notice].should be_nil
      response.should render_template('new')
    end

    it "should pass params to variable" do
      post :create, :variable => { :name => 'cena' }
      assigns[:variable].name.should == 'cena'
    end

    it "should increment Variables count" do
      lambda do
        post :create, :variable => { :name => 'cena' }
      end.should change(Variable, :count).by(1)
    end
  end
end

describe Admin::VariablesController, "edit" do
  describe "when user not logged in" do
    it "should be redirected" do
      get :edit
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

  describe "when user logged in" do
    fixtures :variables

    before(:each) do
      login_as 'user'
      get :edit, :id => variables(:price)
    end

    it "should be successful" do
      response.should be_success
    end

    it "should render 'new' template" do
      response.layout.should == 'layouts/admin/administration'
      response.should render_template('edit')
    end

    it "should assign variable" do
      assigns[:variable].should_not be_nil
    end
  end
end

describe Admin::VariablesController, "update" do
  fixtures :variables

  describe "when user not logged in" do
    it "should be redirected" do
      put :update, :id => variables(:price)
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

  describe "when user logged in" do
    before(:each) do
      login_as 'user'
    end

    it "should redirect to variables path with a notice on successful update" do
      Variable.stub!(:valid?).and_return(true)
      put :update, :id => variables(:price), :variable => { :name => 'new name' }
      assigns[:variable].should_not be_nil
      flash[:notice].should_not be_nil
      response.should redirect_to(admin_variables_path)
    end

    it "should re-render edit template on failed update" do
      Variable.stub!(:valid?).and_return(false)
      put :update, :id => variables(:price), :variable => { :name => '' }
      assigns[:variable].should_not be_nil
      flash[:notice].should be_nil
      response.should render_template('edit')
    end

    it "should pass params to variable" do
      put :update, :id => variables(:price), :variable => { :name => 'new name' }
      assigns[:variable].name.should == 'new name'
    end

    it "should not increment Variable count" do
      Variable.stub!(:valid?).and_return(true)
      lambda do
        put :update, :id => variables(:price), :variable => { :name => 'new name' }
      end.should_not change(Variable, :count)
    end
  end
end

describe Admin::VariablesController, "show" do
  fixtures :variables

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
      get :show, :id => variables(:price)
    end

    it "should be successful" do
      response.should be_success
    end

    it "should render 'show' template" do
      response.layout.should == 'layouts/admin/administration'
      response.should render_template('show')
    end

    it "should assign variable" do
      assigns[:variable].should_not be_nil
    end
  end
end