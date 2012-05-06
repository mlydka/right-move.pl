module AuthenticatedSystem
  protected

  def authenticate login, password
    if login == 'admin' and password == 'secret'
      session[:user] = 'admin'
    end
  end

  def logged_in?
    !!session[:user]
  end

  def login_required
    logged_in? || access_denied
  end

  def access_denied
    redirect_to login_path
  end

  def self.included(base)
    base.send :helper_method, :logged_in? if base.respond_to? :helper_method
  end

end
