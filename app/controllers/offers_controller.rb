class OffersController < ApplicationController
  before_filter :get_offers_for_slider, :except => [ :search ]
	
  def show
		return redirect_to root_path unless @offer
		@main_category = @category.parent ? @category.parent : @category
  end

	def	search
	  @type = Type.find_by_name(params[:typ] == 'wynajem' ? 'wynajem' : 'sprzedaż')	  
		@main_category = Category.find_by_name(params[:categoria])

		category_conditions = @main_category ? " and categories.parent_id = #{@main_category.id}" : ''

		if Address.find_by_district(params[:lokalizacja])
		  address_conditions = " and addresses.district like '%#{params[:lokalizacja]}%'"
		elsif params[:lokalizacja] == 'inne'
		  address_conditions = " and addresses.district not in ('#{Address.get_cracov_districts.join("','")}')"
		else
		  address_conditions = ''
		end

    @offers_for_slider = Offer.find(:all, :joins => [:category, :address], :conditions => ['type_id = ?' + category_conditions + address_conditions, @type.id])

		unless @offers_for_slider.empty?
		  @offer = @offers_for_slider.first
			render :action => :show
		else
		  render :template => 'categories/show'
		end
	end	

end
