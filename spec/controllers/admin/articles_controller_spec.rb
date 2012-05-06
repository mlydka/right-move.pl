require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::ArticlesController, "index" do
  describe "when user not logged in" do
    it "should be redirected" do
      get :index
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

  describe "when user logged in" do
    fixtures :articles

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

    it "should get articles" do
      assigns[:articles].should_not be_empty
    end
  end
end

describe Admin::ArticlesController, "new" do
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

    it "should create new article" do
      assigns[:article].should_not be_nil
      assigns[:article].should be_new_record
    end
  end
end

describe Admin::ArticlesController, "create" do
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

    it "should redirect to articles path with a notice on successful save" do
      Article.stub!(:valid?).and_return(true)
      post :create, :article => { :title => 'title', :introduction => 'introduction', :content => 'content' }
      assigns[:article].should_not be_new_record
      flash[:notice].should_not be_nil
      response.should redirect_to(admin_articles_path)
    end

    it "should re-render new template on failed save" do
      Article.stub!(:valid?).and_return(false)
      post :create, :article => { :title => '', :introduction => 'introduction', :content => 'content' }
      assigns[:article].should be_new_record
      flash[:notice].should be_nil
      response.should render_template('new')
    end

    it "should pass params to article" do
      post :create, :article => { :title => 'title', :introduction => 'introduction', :content => 'content' }
      assigns[:article].title.should == 'title'
    end

    it "should increment Articles count" do
      lambda do
        post :create, :article => { :title => 'title', :introduction => 'introduction', :content => 'content' }
      end.should change(Article, :count).by(1)
    end
  end
end

describe Admin::ArticlesController, "edit" do
  describe "when user not logged in" do
    it "should be redirected" do
      get :edit
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

  describe "when user logged in" do
    fixtures :articles

    before(:each) do
      login_as 'user'
      get :edit, :id => articles(:first)
    end

    it "should be successful" do
      response.should be_success
    end

    it "should render 'new' template" do
      response.layout.should == 'layouts/admin/administration'
      response.should render_template('edit')
    end

    it "should assign article" do
      assigns[:article].should_not be_nil
    end
  end
end

describe Admin::ArticlesController, "update" do
  fixtures :articles

  describe "when user not logged in" do
    it "should be redirected" do
      put :update, :id => articles(:first)
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

  describe "when user logged in" do
    before(:each) do
      login_as 'user'
    end

    it "should redirect to articles path with a notice on successful update" do
      Article.stub!(:valid?).and_return(true)
      put :update, :id => articles(:first), :article =>{ :title => 'title', :introduction => 'introduction', :content => 'content' } 
      assigns[:article].should_not be_nil
      flash[:notice].should_not be_nil
      response.should redirect_to(admin_articles_path)
    end

    it "should re-render edit template on failed update" do
      Article.stub!(:valid?).and_return(false)
      put :update, :id => articles(:first), :article => { :title => '', :introduction => 'introduction', :content => 'content' }
      assigns[:article].should_not be_nil
      flash[:notice].should be_nil
      response.should render_template('edit')
    end

    it "should pass params to article" do
      put :update, :id => articles(:first), :article => { :title => 'new title', :introduction => 'introduction', :content => 'content' }
      assigns[:article].title.should == 'new title'
    end

    it "should not increment Article count" do
      Article.stub!(:valid?).and_return(true)
      lambda do
        put :update, :id => articles(:first), :article => { :title => 'title', :introduction => 'introduction', :content => 'content' }
      end.should_not change(Article, :count)
    end
  end
end

describe Admin::ArticlesController, "show" do
  fixtures :articles

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
      get :show, :id => articles(:first)
    end

    it "should be successful" do
      response.should be_success
    end

    it "should render 'show' template" do
      response.layout.should == 'layouts/admin/administration'
      response.should render_template('show')
    end

    it "should assign article" do
      assigns[:article].should_not be_nil
    end
  end
end

describe Admin::ArticlesController, "destroy" do
  fixtures :articles

  describe "when user not logged in" do
    it "should be redirected" do
      delete :destroy, :id => articles(:first)
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end

  describe "when user logged in" do
    before(:each) do
      login_as 'user'
    end

    it "should decrement Article count" do
      lambda do
        delete :destroy, :id => articles(:first)
      end.should change(Article, :count).by(-1)
    end

    it "should be redirected with a notice on successful delete" do
      delete :destroy, :id => articles(:first)
      response.should be_redirect
      response.should redirect_to(admin_articles_path)
      flash[:notice].should_not be_nil
    end
  end
end
