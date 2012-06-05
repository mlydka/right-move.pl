# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  include AuthenticatedSystem

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'efc81f77394ba41f1f08a829bb74233e'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password
		
  protected
    
  def get_offers_for_slider
	  @offers_for_slider = case controller_name
		  when 'categories' then
			  @type      = Type.find_by_name(params[:type])
			  @category  = Category.find_by_name(params[:name])
				@category.active_offers_by_type @type
			when 'offers' then
			  @offer = Offer.get_from_url params[:url]
				@category = @offer.category
				@type = @offer.type
 			  @category.active_offers_by_type @type
			end
			
	  @offers_for_slider = Offer.find_all_by_status(true) if ( @offers_for_slider.nil? || @offers_for_slider.empty? )
  end

end