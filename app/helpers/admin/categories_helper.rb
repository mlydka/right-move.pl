module Admin::CategoriesHelper

  def category_reorder_link category
    html = ''
    if category.parent
      unless category.is_last?
        html += link_to_remote image_tag('down.png'), :url => reorder_admin_category_path(category, :direction => 'down'), :method => :put, :html => { :class => 'reorder' }
      end
      unless category.is_first?
        html += link_to_remote image_tag('up.png'), :url => reorder_admin_category_path(category, :direction => 'up'), :method => :put, :html => { :class => 'reorder' }
      end
    end
    html
  end

	def options_from_offers_collection category, type
	  result = []
		if category.is_parent?
		  category.children.each do |child|
			   result = result + options_from_child_offers_collection(child, type)
			end
		else
		  result = options_from_child_offers_collection category, type
		end
		result
	end

	private

	def options_from_child_offers_collection category, type
	  result = []
	  category.active_offers_by_type(type).each do |offer|
		  result << [ offer.address.district + ', ' + offer.address.street + ', ' + offer.address.apartment, offer.id ]
	  end
		result
	end

end
