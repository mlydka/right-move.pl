require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/articles/new" do
  before(:each) do
    assigns[:article] = Article.new
    render 'admin/articles/new'
  end

  it "should display header" do
    response.should have_tag('h3.header', 'Dodaj Artykuł')
  end

  it "should display new form" do
    response.should have_tag("div.form > form#new_article[action=/admin/articles]")
  end

  it "should display form inputs" do
    response.should have_tag("input#article_title[type=text]")
    response.should have_tag("textarea#article_introduction")
    response.should have_tag("textarea#article__content_editor")
    response.should have_tag("input[type=submit]")
  end

  it "should display cancel link" do
    response.should have_tag("a[href=/admin/articles]", 'Anuluj')
  end
end
