require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/categories/new" do
  fixtures :categories

  before(:each) do
    assigns[:category] = Category.new
    render 'admin/categories/new'
  end

  it "should display header" do
    response.should have_tag('h3.header', 'Dodaj Kategorię')
  end

  it "should display new form" do
    response.should have_tag("div.form > form#new_category[action=/admin/categories]")
  end

  it "should display form inputs" do
    response.should have_tag("input#category_name[type=text]")
    response.should have_tag("select#category_parent_id") do
      with_tag('option', :count => 4)
    end
    response.should have_tag("input[type=submit]")
  end

  it "should display cancel link" do
    response.should have_tag("a[href=/admin/categories]", 'Anuluj')
  end
end
