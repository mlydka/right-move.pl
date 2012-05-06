module OffersHelper

  def get_offer_image_alt_text offer
	  "#{offer.category.parent.name}-#{offer.address.city}-#{offer.address.street}".to_url_format
  end

  def get_offer_link_title_text offer
	  address = offer.address

	  text  = offer.category.parent.name
		text += address.city ? " #{address.city}" : ""
		text += address.district ? " #{address.district}" : ""
		text += address.street ? " #{address.street}" : ""
		text.downcase
  end

	def offer_address_header offer
	  address = offer.address
		text    = ""

		case offer.category.parent.name
		  when 'mieszkania' then
			  text += address.street ? "ul. #{address.street}" : ""
		    text += address.district ? ", #{address.district}" : ""
		    text += address.city ? ", #{address.city}" : ""
      when 'domy' then
        text += address.street ? "ul. #{address.street}" : ""
        text += address.district ? ", #{address.district}" : ""
        text += address.city ? ", #{address.city}" : ""
			when 'działki' then
			  text += address.street ? "#{address.street}" : ""
        text += address.district ? ", #{address.district}" : ""
      when 'lokale użytkowe' then
			  text += address.street ? "ul. #{address.street}" : ""
        text += address.district ? ", #{address.district}" : ""
        text += address.city ? ", #{address.city}" : ""
		end 
  end

	def images_navigation offer
		text = '';
	  #text = link_to_function image_tag('btn-dalej.png', :alt => 'dalej'), 'toggle_image_right()', { :class => 'dalej', :title => 'dalej' }
	  offer.images.each_with_index do |img, index|
		  index = offer.images.count - index
	    text += link_to_function index, "toggle_selected_image(this, #{index})", { :class => ( index == 1  ? ' active' : '' ) }
		end
    #text += link_to_function image_tag('btn-wstecz.png', :alt => 'wstecz'), 'toggle_image_left()', { :class => 'wstecz', :title => 'wstecz' }
		text
  end

	def options_for_district_select
	  $array = [['lokalizacja', 'dowolna']]

		Address.get_cracov_districts.each do |district|
		  $array << [district, district] unless district.empty?
		end
		$array << ['inne','inne']

	  options_for_select($array)
	end

end
