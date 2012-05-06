require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/articles/new" do
  fixtures :articles

  before(:each) do
    @article = articles(:first)
    assigns[:article] = @article
    render 'admin/articles/edit'
  end

  it "should display header" do
    response.should have_tag('h3.header', 'Edytuj Artykuł')
  end

  it "should display edit form" do
    response.should have_tag("div.form > form#edit_article_#{@article.id}[action=/admin/articles/#{@article.id}]")
  end

  it "should display form inputs" do
    response.should have_tag("input#article_title[type=text][value=#{@article.title}]")
    response.should have_tag("textarea#article_introduction", @article.introduction)
    response.should have_tag("textarea#article_#{@article.id}_content_editor", @article.content)
    response.should have_tag("input[type=submit]")
  end

  it "should display cancel link" do
    response.should have_tag("a[href=/admin/articles]", 'Anuluj')
  end
end