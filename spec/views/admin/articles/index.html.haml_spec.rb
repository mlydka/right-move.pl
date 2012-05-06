require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/articles/index" do
  fixtures :articles

  before(:each) do
    assigns[:articles] = Article.find(:all)
    @article = Article.find(:first)
    render 'admin/articles/index'
  end

  it "should display header" do
    response.should have_tag('h3.header', 'Artykuły')
  end
  
  it "should display table with articles" do
    response.should have_tag('table > tr', :count => Article.count + 1) do
      with_tag('td', @article.title)
      with_tag("td > a[href=/admin/articles/#{@article.id}]", 'Pokaż')
      with_tag("td > a[href=/admin/articles/#{@article.id}/edit]", 'Edytuj')
      with_tag("td > a[href=/admin/articles/#{@article.id}]", 'Usuń')
    end
  end

  it "should display add new Article link" do
    response.should have_tag("a[href=/admin/articles/new]", 'Dodaj')
  end
end