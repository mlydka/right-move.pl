require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/variables/show" do
  fixtures :variables

  before(:each) do
    @variable = variables(:price)
    assigns[:variable] = @variable
    render 'admin/variables/show'
  end

  it "should display header" do
    response.should have_tag('h3.header', 'Zmienna')
  end
  
  it "should display variable name" do
    response.should have_tag('p', "Nazwa #{@variable.name}")
  end

  it "should display categories associated with variable" do
    response.should have_tag('ul') do
      with_tag('li', :count => @variable.categories.count)
    end
  end
  
  it "should display go back link" do
    response.should have_tag("a[href=/admin/variables]", 'Wstecz')
  end
end