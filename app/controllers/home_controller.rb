class HomeController < ApplicationController
  before_filter :get_offers_for_slider

  def index
	  @content = Content.find_by_type('homepage')
  end

  def about
	  @content = Content.find_by_type('about')
		render :action => 'index'
  end

  def policy
	  @content = Content.find_by_type('policy')
		render :action => 'index'
  end

	def career
    @content = Content.find_by_type('career')
		render :action => 'index'
	end

  def contact
  end

  def user_offer
    @user_offer = UserOffer.new
    @user_offer.type = 'sprzedaz'
  end

  def submit_user_offer
    @user_offer = UserOffer.new
    @user_offer.type = 'sprzedaz'

    if params['user_offer']
      @user_offer.type       = params['user_offer']['type']
      @user_offer.category   = params['user_offer']['category']
      @user_offer.email      = params['user_offer']['email']
      @user_offer.firstname  = params['user_offer']['firstname']
      @user_offer.lastname   = params['user_offer']['lastname']
      @user_offer.phone      = params['user_offer']['phone']
      @user_offer.city       = params['user_offer']['city']
      @user_offer.district   = params['user_offer']['district']
      @user_offer.street     = params['user_offer']['street']
      @user_offer.price      = params['user_offer']['price']
      @user_offer.area       = params['user_offer']['area']
    end

    if @user_offer.valid?
      Mailer.deliver_user_offer(@user_offer)
      flash[:notice] = "Dziękujemy za zainteresowanie naszą offertą"
      redirect_to root_url
    else
      render :action => 'user_offer'
    end
  end

  def user_request
    @user_request = UserRequest.new
    @user_request.type = 'sprzedaz'
  end

  def submit_user_request
    @user_request = UserRequest.new
    @user_request.type = 'sprzedaz'
    
    if params['user_request']
      @user_request.type       = params['user_request']['type']
      @user_request.category   = params['user_request']['category']
      @user_request.email      = params['user_request']['email']
      @user_request.firstname  = params['user_request']['firstname']
      @user_request.lastname   = params['user_request']['lastname']
      @user_request.phone      = params['user_request']['phone']
      @user_request.city       = params['user_request']['city']
      @user_request.district   = params['user_request']['district']
      @user_request.street     = params['user_request']['street']

      @user_request.price_from  = params['user_request']['price_from']
      @user_request.price_to    = params['user_request']['price_to']
      @user_request.price2_from = params['user_request']['price2_from']
      @user_request.price2_to   = params['user_request']['price2_to']
      @user_request.area_from   = params['user_request']['area_from']
      @user_request.area_to     = params['user_request']['area_to']
    end

    if @user_request.valid?
      Mailer.deliver_user_request(@user_request)
      flash[:notice] = "Dziękujemy za zainteresowanie naszą offertą"
      redirect_to root_url
    else
      render :action => 'user_request'
    end
  end

end
