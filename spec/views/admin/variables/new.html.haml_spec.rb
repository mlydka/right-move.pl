require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/variables/new" do
  before(:each) do
    assigns[:variable] = Variable.new
    render 'admin/variables/new'
  end

  it "should display header" do
    response.should have_tag('h3.header', 'Dodaj Zmienną')
  end

  it "should display new form" do
    response.should have_tag("div.form > form#new_variable[action=/admin/variables]")
  end

  it "should display form inputs" do
    response.should have_tag("input#variable_name[type=text]")
    response.should have_tag("input[type=submit]")
  end

  it "should display cancel link" do
    response.should have_tag("a[href=/admin/variables]", 'Anuluj')
  end
end
