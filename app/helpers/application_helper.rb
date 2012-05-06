# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	def title page_title
	  content_for(:title) { page_title }
  end

  def setCssClassForMainSection
		if action_name == 'search'
		  class_name = 'wyszukiwarka'
	  elsif ['categories', 'offers'].include?(controller.controller_name)
			type = Type.get_from_url(request.request_uri)
      category = Category.get_from_url_or_default(request.request_uri)

		  class_name = (type.name + ' ' + category.name).to_url_format
		end

		unless class_name.blank?
	    update_page_tag do |page|
        page.call "$('main').toggleClassName", "#{class_name}"
      end
    end

  end

	def setCssClassForEmptyCategory
    update_page_tag do |page|
      page.call "$('main').toggleClassName", "brak-ofert"
    end
  end

	def pluralize_pl(count, one, few, other)
	  count = count.to_i
	  if (count == 1 || count == '1')
		  "#{count || 0} " + one
    elsif ( [2,3,4].include?(count%10) && ![12,13,14].include?(count%100) && ![22,23,24].include?(count%100) )   
		  "#{count || 0} " + few
	  else
		  "#{count || 0} " + other
		end
  end

end
