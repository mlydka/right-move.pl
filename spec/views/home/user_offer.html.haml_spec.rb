require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "home/user_offer" do

  before(:each) do
    render 'home/user_offer'
  end

  it "should display new form" do
    response.should have_tag("form[action=/zglos_oferte]")
  end

end
