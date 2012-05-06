require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "articles/show" do
  fixtures :articles

  before(:each) do
    @article = Article.find(:first)
    assigns[:article] = @article
    
    render 'articles/show'
  end
  
  it "should display back to all articles link" do
    response.should have_tag("a[href=/artykuly]", 'powrót')
  end
end