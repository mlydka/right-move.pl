require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/categories/index" do
  fixtures :categories

  before(:each) do
    assigns[:categories] = Category.find(:all)
    @category = categories(:oneroom_apartments)
    render 'admin/categories/index'
  end

  it "should display header" do
    response.should have_tag('h3.header', 'Kategorie')
  end
  
  it "should display table with Categories" do
    response.should have_tag('table > tr', :count => 8) do
      with_tag('td', @category.name)
      with_tag('td', @category.parent.name)
      with_tag("td > a[href=/admin/categories/#{@category.id}]", 'Pokaż')
      with_tag("td > a[href=/admin/categories/#{@category.id}/edit]", 'Edytuj')
      with_tag("td > a[href=/admin/categories/#{@category.id}]", 'Usuń')
    end
  end

  it "should display add new Category link" do
    response.should have_tag("a[href=/admin/categories/new]", 'Dodaj')
  end
end