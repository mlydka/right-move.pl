module Admin::OffersHelper

  def add_image_link name
    link_to_function name do |page|
      page.insert_html :bottom, :images, :partial => 'image', :object => Image.new
    end
  end
  
end
