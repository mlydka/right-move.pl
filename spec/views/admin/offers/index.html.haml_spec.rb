require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/offers/index" do
  fixtures :offers, :addresses

  before(:each) do
    assigns[:offers] = Offer.find(:all)
    @offer = Offer.find(:first)
    render 'admin/offers/index'
  end

  it "should display header" do
    response.should have_tag('h3.header', 'Oferty')
  end

  it "should display offers list" do
    response.should have_tag("table > tr") do
      have_tag('th', :count => 8)
    end
  end
  
  it "should display add new Offer link" do
    response.should have_tag("a[href=/admin/offers/new]", 'Dodaj')
  end
end