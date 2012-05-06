class Admin::CategoriesController < ApplicationController
  layout 'admin/administration'

  before_filter :login_required

  def index
    @categories = Category.find_all_by_parent_id(nil)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = 'Category was successfully created.'
      redirect_to admin_categories_path
    else
      render :action => 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = "Category was successfully updated."
      redirect_to admin_categories_path
    else
      render :action => :edit
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def destroy
    @category = Category.find(params[:id])
    unless @category.children.empty?
      flash[:error] = 'Please delete all subcategories first.'
    else
      @category.destroy
      flash[:notice] = 'Category was successfully deleted.'
    end
    redirect_to admin_categories_path
  end
  
  def toggle_variables_form
    if request.xhr?
      render :update do |page|
        unless params[:category_id].to_s.empty?
          page.replace_html :variables, ''
        else
	  page.replace_html :variables, :partial => 'variables', :locals => { :category => Category.new } 
	end
      end
    else
      return render(:text => '', :status => 404)
    end
  end

  def reorder
    if request.xhr? && ( category = Category.find(params[:id]) ) && ( ['up', 'down'].include?(params[:direction]) )
       if neighbor = category.get_neighbor(params[:direction])
         neighbor_position = neighbor.position
         neighbor.update_attribute('position', category.position)
         category.update_attribute('position', neighbor_position)
       end
       @categories = Category.find_all_by_parent_id(nil)
       render :update do |page|
         page.replace_html :categories, :partial => 'categories'
	 page.visual_effect :highlight, "category_#{neighbor.id}"
 	 page.visual_effect :highlight, "category_#{category.id}"
       end
    else
      return redirect_to admin_categories_path
    end
  end

end
