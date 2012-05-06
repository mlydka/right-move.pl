require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomeController do

  describe 'index' do
    it 'should be successful' do
      get :index

      response.should be_success
      response.layout.should == 'layouts/application'
      response.should render_template 'index'
    end

    it 'should call get_offers_for_slider' do
      @offers = Offer.find_all_by_status(:all, true, :limit => 7)
      controller.should_receive(:get_offers_for_slider).once.and_return(@offers)
      get :index
    end
  end 
  
  describe 'about' do
    it 'should be successful' do
      get :about

      response.should be_success
      response.layout.should == 'layouts/application'
      response.should render_template 'about'
    end
  end

  describe 'news' do
    it 'should be successful' do
      get :news

      response.should be_success
      response.layout.should == 'layouts/application'
      response.should render_template 'news'
    end
  end

  describe 'contact' do
    it 'should be successful' do
      get :contact

      response.should be_success
      response.layout.should == 'layouts/application'
      response.should render_template 'contact'
    end
  end

  describe 'user_offer' do
    it 'should be successful' do
      get :user_offer

      response.should be_success
      response.layout.should == 'layouts/application'
      response.should render_template 'user_offer'
    end
  end

  describe 'user_request' do
    it 'should be successful' do
      get :user_request

      response.should be_success
      response.layout.should == 'layouts/application'
      response.should render_template 'user_request'
    end
  end 

end
