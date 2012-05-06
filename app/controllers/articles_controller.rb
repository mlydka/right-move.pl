class ArticlesController < ApplicationController
  before_filter :get_offers_for_slider

  def index
    @articles = Article.find(:all)
  end

  def show
    @article = Article.find(params[:id])
  end

end
