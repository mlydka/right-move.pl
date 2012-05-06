require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/offers/edit" do
  fixtures :offers, :addresses, :categories, :images

  before(:each) do
    @offer = offers(:flat)
    @address = @offer.address
    @category = @offer.category
    @type = @offer.type
    @image = @offer.images.build
    assigns[:offer] = @offer
    assigns[:address] = @address
    assigns[:image] = @image
    render 'admin/offers/edit'
  end

  it "should display header" do
    response.should have_tag('h3.header', 'Edytuj Ofertę')
  end

  it "should display new form" do
    response.should have_tag("div.form > form#edit_offer_#{@offer.id}[action=/admin/offers/#{@offer.id}][enctype=multipart/form-data]")
  end

  it "should display form inputs for offer" do
    response.should have_tag('div.r') do
      with_tag('label[for=offer_status_false]') do
        with_tag('input#offer_status_false[type=radio][value=false]')
      end
      with_tag('label[for=offer_status_true]') do
        with_tag('input#offer_status_true[type=radio][value=true][checked=checked]')
      end
    end

    response.should have_tag('select#offer_category_id[disabled=disabled]') do
      with_tag("option[value=#{@category.id}][selected=selected]")
    end
    
    response.should have_tag('select#offer_type_id') do
      with_tag("option[value=#{@type.id}][selected=selected]")
    end

    response.should have_tag('input[type=text][value=4321]#offer_code')	
    response.should have_tag('p.description > textarea#offer_description', 'To bardzo fajna oferta ...')

    response.should_not have_tag('input#offer_serial[type=hidden]')
  end

  it "should create observer for category select" do
     response.should_not include_text("new Form.Element.EventObserver('offer_category_id', ")
  end

  it "should display form inputs for address" do
    ['firstname', 'lastname', 'city', 'district', 'street', 'apartment', 'zip', 'email', 'phone'].each do |attr|
      response.should have_tag("input#offer_address_attributes_#{attr}[type=text][value=#{@address.send(attr)}]")
    end
  end
  
  it "should display container for images" do
    response.should have_tag('div.form_images')
  end

  it "should display new images list" do
    response.should have_tag('div.form_images > ul#images') do
      with_tag('li', :count => 1)
      with_tag("li#image_#{@offer.images.first.id}") do
        with_tag('img')
        with_tag('a', 'Delete')
      end
    end
    response.should include_text("new Ajax.Request('/admin/offers/destroy_image?image_id=#{@offer.images.first.id}', ")
  end

  it "should display form for new images" do
    response.should have_tag('div.form_images > form[target=frame][action=/admin/offers/upload_image][enctype=multipart/form-data]') do
      with_tag('input#image_uploaded_data[type=file]')
      with_tag("input#image_offer_id[type=hidden][value=#{@offer.id}]")
    end
  end

  it "should display iframe" do
    response.should have_tag('iframe#frame[name=frame][src=about:blank]')
  end

  it "should display cancel link" do
    response.should have_tag("a[href=/admin/offers]", 'Anuluj')
  end
end
