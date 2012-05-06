require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/variables/edit" do
  fixtures :variables

  before(:each) do
    @variable = variables(:area)
    assigns[:variable] = @variable
    render 'admin/variables/edit'
  end

  it "should display header" do
    response.should have_tag('h3.header', 'Edytuj Zmienną')
  end

  it "should display edit form" do
    response.should have_tag("div.form > form#edit_variable_#{@variable.id}[action=/admin/variables/#{@variable.id}]")
  end

  it "should display form inputs" do
    response.should have_tag("input#variable_name[type=text][value=#{@variable.name}]")
    response.should have_tag("input[type=submit]")
  end

  it "should display cancel link" do
    response.should have_tag("a[href=/admin/variables]", 'Anuluj')
  end
end