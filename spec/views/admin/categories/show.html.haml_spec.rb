require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/categories/show" do
  fixtures :categories, :variables

  before(:each) do
    @category = categories(:allotments)
    assigns[:category] = @category
    render 'admin/categories/show'
  end

  it "should display header" do
    response.should have_tag('h3.header', 'Kategoria')
  end
  
  it "should display category name" do
    response.should have_tag('p', "Nazwa: #{@category.name}")
  end

  it "should display variables associated with category" do
    response.should have_tag('ul') do
      with_tag('li', :count => @category.variables.count)
    end
  end
  
  it "should display go back link" do
    response.should have_tag("a[href=/admin/categories]", 'Wstecz')
  end
end

describe "admin/categories/show", 'with parent category' do
  fixtures :categories, :variables

  before(:each) do
    @category = categories(:oneroom_apartments)
    assigns[:category] = @category
    render 'admin/categories/show'
  end

  it "should display parent category name" do
    response.should have_tag('p', "Kategoria nadrzędna: #{@category.parent.name}")
  end
end