class Admin::OffersController < ApplicationController
  layout 'admin/administration'

  before_filter :login_required

  def index
    @offers = Offer.find(:all, :include => :address)
  end

  def new
    serial = generate_serial
    @offer = Offer.new(:serial => serial)
    @address = @offer.build_address
  end

  def upload_image
    @image = Image.new(params[:image])
    if @image.save
      responds_to_parent do
        render :update do |page|
	  page.insert_html :bottom, 'images', :partial => 'image', :object => @image
	  page['new_image'].reset
	end
      end
    else
      return render(:nothing => true)
    end
  end

  def destroy_image
    @image = Image.find(params[:image_id])
    if @image.destroy
      render :update do |page|
        page.remove "image_#{@image.id}"
      end
    else
      return render(:nothing => true)
    end
  end

  def create
    @offer = Offer.new(params[:offer])
    if @offer.save
      flash[:notice] = 'Offer was successfully created.'
      redirect_to admin_offers_path
    else
      @address = @offer.address
      render :action => 'new'
    end
  end

  def edit
    @offer = Offer.find(params[:id], :include => [:address, :offers_variables, :images])
    @offer.apply_variables_from_category
    @address = @offer.address
  end

  def update
    params[:offer].delete(:category_id)

    @offer = Offer.find(params[:id])
    if @offer.update_attributes(params[:offer])
      flash[:notice] = "Offer was successfully updated."
      redirect_to admin_offers_path
    else
      @address = @offer.address
      render :action => :edit
    end
  end

  def destroy
    Offer.find(params[:id]).destroy
    flash[:notice] = 'Offer was successfully deleted.'
    redirect_to admin_offers_path
  end

  def toggle_variables_form
    if request.xhr?
      return render :nothing => true if params[:category_id].to_s.empty?

      category = Category.find(params[:category_id], :include => [:categories_variables, :variables])

      render :update do |page|
        page.replace_html :variables, ''
				category.parent.categories_variables.each_with_index do |categories_variable, index|
	  		  offer_variable = OffersVariable.new(:variable => categories_variable.variable)
          page.insert_html :bottom, :variables, :partial => 'form_variable', :locals => { :form_variable => offer_variable, :categories_variable => categories_variable }
					if index == 4
					  page.insert_html :bottom, :variables, "<div class='clear' />"
					end
				end
      end
    else
      return render(:text => '', :status => 404)
    end
  end


  private

  def generate_serial
    Digest::SHA1.hexdigest(Kernel.rand(1000000).to_s + "rand")[0..15]
  end

end
