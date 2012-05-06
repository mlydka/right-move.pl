require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "sessions/new" do
  before(:each) do
    render 'sessions/new'
  end  

  it "should display login form" do
    response.should have_tag("div.login > form[action=/sessions]")
  end

  it "should display form inputs" do
    response.should have_tag("input#login[type=text]")
    response.should have_tag("input#password[type=password]")

    response.should have_tag("input[type=submit]")
  end
end