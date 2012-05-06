require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/offers/new" do
  fixtures :categories

  before(:each) do
    assigns[:offer] = Offer.new(:serial => 'qwerty')
    assigns[:address] = Address.new
    assigns[:image] = Image.new(:serial => 'qwerty')
    render 'admin/offers/new'
  end

  it "should display header" do
    response.should have_tag('h3.header', 'Dodaj Ofertę')
  end

  it "should display new form" do
    response.should have_tag("div.form > form#new_offer[action=/admin/offers][enctype=multipart/form-data]")
  end

  it "should display form inputs for offer" do
    response.should have_tag('div.r') do
      with_tag('label[for=offer_status_false]') do
        with_tag('input#offer_status_false[type=radio][value=false][checked=checked]')
      end
      with_tag('label[for=offer_status_true]') do
        with_tag('input#offer_status_true[type=radio][value=true]')
      end
    end
    
    response.should have_tag('select#offer_category_id') do
      with_tag('optgroup', :count => Category.find_all_by_parent_id(nil).size)
    end
        
    response.should have_tag('select#offer_type_id') do
      with_tag('option', :count => Type.count + 1)
    end

    response.should have_tag('input[type=text]#offer_code')
    response.should have_tag('textarea#offer_description')

    response.should have_tag('input#offer_serial[type=hidden][value=qwerty]')
  end

  it "should create observer for category select" do
     response.should include_text("new Form.Element.EventObserver('offer_category_id', ")
     response.should include_text("new Ajax.Request('/admin/offers/toggle_variables_form', ")
  end 

  it "should display form inputs for address" do
    ['firstname', 'lastname', 'city', 'district', 'street', 'apartment', 'zip', 'email', 'phone'].each do |attr|
      response.should have_tag("input#offer_address_attributes_#{attr}[type=text]")
    end
  end

  it "should display container for images" do
    response.should have_tag('div.form_images')
  end

  it "should display new images list" do
    response.should have_tag('div.form_images > ul#images') do
      with_tag('li', :count => 0)
    end
  end

  it "should display form for new images" do
    response.should have_tag('div.form_images > form[target=frame][action=/admin/offers/upload_image][enctype=multipart/form-data]') do
      with_tag('input#image_uploaded_data[type=file]')
      with_tag('input#image_serial[type=hidden][value=qwerty]')
    end
  end

  it "should display iframe" do
    response.should have_tag('iframe#frame[name=frame][src=about:blank]')
  end

  it "should display container for variables" do
    response.should have_tag('div#variables', '')
  end
end
