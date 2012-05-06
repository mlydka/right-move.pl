require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "articles/list" do
  fixtures :articles

  before(:each) do
    @articles = Article.find(:all)
    assigns[:articles] = @articles
  end
  
  it "should render partial" do
    template.should_receive(:render).with hash_including(:partial => 'article', :collection => @articles)
    render 'articles/index'
  end

  it "should display articles list" do
    render 'articles/index'
    response.should have_tag('div.Akapit', :count => @articles.size)

  end

  it "should display show more link" do
    render 'articles/index'
    response.should have_tag("a[href=/artykuly/#{@articles.first.id}]", 'więcej')
  end
end
