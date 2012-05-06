module Admin::CategoriesVariablesHelper
       
  def add_option_link name
    link_to_function name do |page|
      page.insert_html :bottom, :options, :partial => 'option', :object => Option.new
    end
  end

end
