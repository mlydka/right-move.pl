require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/categories/new" do
  fixtures :categories, :variables

  before(:each) do
    @category = categories(:oneroom_apartments)
    assigns[:category] = @category
    render 'admin/categories/edit'
  end

  it "should display header" do
    response.should have_tag('h3.header', 'Edytuj Kategorię')
  end

  it "should display edit form" do
    response.should have_tag("div.form > form#edit_category_#{@category.id}[action=/admin/categories/#{@category.id}]")
  end

  it "should display form inputs" do
    response.should have_tag("input#category_name[type=text][value=#{@category.name}]")
    response.should have_tag("select#category_parent_id") do
      with_tag('option[selected=selected]', categories(:apartments).name)
    end
    response.should have_tag('input[type=checkbox]', :count => Variable.count)
    response.should have_tag('input[type=checkbox][checked=checked]', :count => @category.variables.count)
    response.should have_tag("input[type=submit]")
  end

  it "should display cancel link" do
    response.should have_tag("a[href=/admin/categories]", 'Anuluj')
  end
end