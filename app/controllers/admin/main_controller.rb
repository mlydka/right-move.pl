class Admin::MainController < ApplicationController
  layout 'admin/administration'

  before_filter :login_required

  def index
  end

end
