require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CategoriesController, 'show' do
  fixtures :categories

  before(:each) do
    get :show, :id => categories(:allotments)
  end

  it "should be successful" do
    response.should be_success
  end

  it "should render 'show' template" do
    response.layout.should == 'layouts/application'
    response.should render_template('show')
  end
end

