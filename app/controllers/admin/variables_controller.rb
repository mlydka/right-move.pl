class Admin::VariablesController < ApplicationController
  layout 'admin/administration'

  before_filter :login_required

  def index
    @categories = Category.find_all_by_parent_id(nil)
  end

  def new
    @variable = Variable.new
  end

  def create
    @variable = Variable.new(params[:variable]) unless @variable = Variable.find_by_name(params[:variable][:name])
    @variable.category_ids = ( @variable.category_ids + params[:variable][:category_ids] ).uniq unless @variable.new_record?

    if @variable.save
      flash[:notice] = 'Variable was successfully created.'
      redirect_to admin_variables_path
    else
      render :action => 'new'
    end
  end

  def edit
    @variable = Variable.find(params[:id])
  end

  def update
    @variable = Variable.find(params[:id])
    if @variable.update_attributes(params[:variable])
      flash[:notice] = "Variable was successfully updated."
      redirect_to admin_variables_path
    else
      render :action => :edit
    end
  end

  def show
    @variable = Variable.find(params[:id], :include => [:categories_variables, :categories])
  end

end