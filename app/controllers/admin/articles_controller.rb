class Admin::ArticlesController < ApplicationController
  layout 'admin/administration'

  before_filter :login_required

  def index
    @articles = Article.find(:all)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      flash[:notice] = 'Article was successfully created.'
      redirect_to admin_articles_path
    else
      render :action => 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      flash[:notice] = "Article was successfully updated."
      redirect_to admin_articles_path
    else
      render :action => :edit
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def destroy
    Article.find(params[:id]).destroy
    flash[:notice] = 'Article was successfully deleted.'
    redirect_to admin_articles_path
  end

end
