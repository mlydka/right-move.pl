module AuthenticatedTestHelper

  def login_as user
    @request.session[:user] = user
  end

end