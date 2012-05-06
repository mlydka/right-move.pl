require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/articles/show" do
  fixtures :articles

  before(:each) do
    @article = articles(:first)
    assigns[:article] = @article
    render 'admin/articles/show'
  end

  it "should display header" do
    response.should have_tag('h3.header', 'Artykuł')
  end
  
  it "should display article properties" do
    response.should include_text(@article.title)
    response.should include_text(@article.content)
  end

  it "should display go back link" do
    response.should have_tag("a[href=/admin/articles]", 'Wstecz')
  end
end