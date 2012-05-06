require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ArticlesController do
  fixtures :articles

  describe 'index' do
    it 'should be successful' do
      get :index

      response.should be_success
      response.layout.should == 'layouts/application'
      response.should render_template 'index'
    end

    it 'should assign instance variable' do
      get :index
      assigns[:articles].should_not be_empty
    end
  end

  describe 'show' do
    it 'should be successful' do
      get :show, :id => articles(:first)

      response.should be_success
      response.layout.should == 'layouts/application'
      response.should render_template 'show'
    end

    it 'should assign instance variable' do
      get :show, :id => articles(:first)
      assigns[:article].should_not be_nil
    end
  end

end
