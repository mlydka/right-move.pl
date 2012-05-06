class SessionsController < ApplicationController
  layout 'admin/administration'

  before_filter :login_required, :only => :destroy

  def new
  end

  def create
    if authenticate(params[:login], params[:password])
      flash[:notice] = "Successfully logged in"
      redirect_to admin_path
    else
      flash[:error] = "Couldn't log you in as '#{params[:login]}'"
      render :action => 'new'
    end
  end

  def destroy
    reset_session
    flash[:notice] = "Successfully logged out"
    redirect_to login_path
  end

end
