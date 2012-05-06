require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "top navigation" do

  it 'should render partial' do
    template.should_receive(:render).with hash_including(:partial => 'layouts/admin/top_nav')
    render 'layouts/admin/administration'
  end

  it 'should display menu' do
    render 'layouts/admin/administration'
    response.should have_tag("div.chromestyle#chromemenu")
  end

  it 'should display main links' do
    render 'layouts/admin/administration'
    response.should have_tag("ul") do
      with_tag("ul > li > a[href=/admin]", 'Home')
      with_tag("ul > li > a[href=/admin/offers]", 'Oferty')
      with_tag("ul > li > a[href=/admin/categories]", 'Kategorie')
      with_tag("ul > li > a[href=/admin/variables]", 'Zmienne')
      with_tag("ul > li > a[href=/admin/articles]", 'Artykuły')
      with_tag("ul > li > a[href=/logout]", 'Logout')
    end
  end

end