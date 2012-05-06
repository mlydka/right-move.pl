class Admin::CategoriesVariablesController < ApplicationController
  layout 'admin/administration'

  before_filter :login_required
  before_filter :get_sortable_array, :only => [ :reorder ]
  skip_before_filter :verify_authenticity_token, :only => [ :reorder ]

  def destroy
    CategoriesVariable.find(params[:id]).destroy
    flash[:notice] = 'Variable was successfully deleted.'
    redirect_to admin_variables_path
  end

  def edit
     @categories_variable = CategoriesVariable.find(params[:id])
  end

  def update
    params[:categories_variable][:existing_option_attributes] ||= {}
    
    @categories_variable = CategoriesVariable.find(params[:id])
    if @categories_variable.update_attributes(params[:categories_variable])
      flash[:notice] = "Options were successfully updated."
      redirect_to admin_variables_path
    else
      render :action => :edit
    end
  end

  def reorder 
    if request.xhr? && @sortable_array
      @sortable_array.each_with_index do |id, index|
        CategoriesVariable.find(id).update_attribute(:position, index+1)
      end
      render :nothing => true
    else
      redirect_to admin_variables_path
    end
  end

	def change_status
	  @categories_variable = CategoriesVariable.find(params[:id])
		@categories_variable.update_attribute(:status, !@categories_variable.status)
		
		render :update do |page|
		  page.replace "categories_variable_#{@categories_variable.id}", :partial => 'admin/variables/categories_variable_row', :object => @categories_variable
			page.replace_html 'subheader', '<div id="notice">Status was successfully updated.</div>'
		end
	end

  protected

  def get_sortable_array
    params.each do |key, value|
      if key =~ /^vars_category_[0-9]+$/
        @sortable_array = value
      	break
      end
    end
  end
      
end
