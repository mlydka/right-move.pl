require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "categories/show" do
  fixtures :categories

  before(:each) do
    assigns[:type] = 'wynajem'
    assigns[:category] = categories(:apartments)
  end

  it "should render middle_nav partial" do
    template.should_receive(:render).with hash_including(:partial => 'middle_nav')
    render 'categories/show'
  end

end
