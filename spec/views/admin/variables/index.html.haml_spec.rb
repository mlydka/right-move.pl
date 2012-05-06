require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/variables/index" do
  fixtures :variables

  before(:each) do
    assigns[:variables] = Variable.find(:all)
    @variable = Variable.find(:first)
    render 'admin/variables/index'
  end

  it "should display header" do
    response.should have_tag('h3.header', 'Zmienne')
  end
  
  it "should display variables list" do
    response.should have_tag('ul > li', :count => Variable.count) do
      with_tag('div.name', @variable.name)
      with_tag("div > a[href=/admin/variables/#{@variable.id}]", 'Pokaż')
      with_tag("div > a[href=/admin/variables/#{@variable.id}/edit]", 'Edytuj')
      with_tag("div > a[href=/admin/variables/#{@variable.id}]", 'Usuń')
    end
  end

  it "should display add new Variable link" do
    response.should have_tag("a[href=/admin/variables/new]", 'Dodaj')
  end
end