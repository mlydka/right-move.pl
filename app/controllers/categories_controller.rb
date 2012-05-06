class CategoriesController < ApplicationController
  before_filter :get_offers_for_slider

  def show
    @main_category = @category.is_parent? ? @category : @category.parent
		@offer = @category.get_special_offer @type

		render :template => 'offers/show.html.haml' if @offer
  end

end
