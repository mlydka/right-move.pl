module CategoriesHelper

  def link_to_category category, sell_or_rent
	  link_to category.label, category.get_url(sell_or_rent), { :title => category.get_link_title(sell_or_rent) }
  end

end
