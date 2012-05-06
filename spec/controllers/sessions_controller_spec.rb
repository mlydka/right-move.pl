require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SessionsController, 'new' do
  it 'should be successful' do
    get :new
    response.should be_success
    response.should render_template('new')
  end
end

describe SessionsController, 'create' do
  it 'should successfuly log in' do
    controller.stub!(:authenticate).and_return(true)
    post :create, {:login => 'login', :password => 'secret'}
    flash[:notice].should_not be_nil
    response.should be_redirect
    response.should redirect_to(admin_path)
  end

  it 'should not log in' do
    controller.stub!(:authenticate).and_return(false)
    post :create, {:login => 'login', :password => 'wrong'}
    flash[:error].should_not be_nil
    response.should be_success
    response.should render_template('new')
  end
end

describe SessionsController, 'destroy' do
  before(:each) do
    login_as 'user'
  end

  it 'should before filter' do
    controller.should_receive(:login_required)
    get :destroy
  end

  it 'should reset session' do
    controller.should_receive(:reset_session)
    get :destroy
  end

  it 'should redirect with notice' do
    get :destroy
    flash[:notice].should_not be_nil
    response.should be_redirect
    response.should redirect_to(login_path)
  end

end
