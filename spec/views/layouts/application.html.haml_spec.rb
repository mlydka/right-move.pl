require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "layouts/_top_nav" do
  
  it "should render partial" do
    template.should_receive(:render).with hash_including(:partial => 'layouts/top_nav')
    render :layout => true
  end

end

describe "layouts/_left_nav" do
  
  it "should render partial" do
    template.should_receive(:render).with hash_including(:partial => 'layouts/left_nav')
    render :layout => true
  end

  it "should display categories links" do
    render :layout => true
    
    response.should have_tag('a[href=/sprzedaz-mieszkania]', 'sprzedaż')
    response.should have_tag('a[href=/wynajem-mieszkania]', 'wynajem')	
    response.should have_tag('a[href=/sprzedaz-domy]', 'sprzedaż')
    response.should have_tag('a[href=/wynajem-domy]', 'wynajem')	
    response.should have_tag('a[href=/sprzedaz-dzialki]', 'sprzedaż')
    response.should have_tag('a[href=/sprzedaz-lokale-komercyjne]', 'sprzedaż')
    response.should have_tag('a[href=/wynajem-lokale-komercyjne]', 'wynajem')	
    response.should have_tag('a[href=/sprzedaz-obiekty-komercyjne]', 'sprzedaż')
    response.should have_tag('a[href=/wynajem-obiekty-komercyjne]', 'wynajem')	
  end

end