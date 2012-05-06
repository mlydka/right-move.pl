class Mailer < ActionMailer::Base

  def user_offer(params)
    setup_email(params)

    @subject       = 'Nowa oferta'
    @body[:params] = params
  end

  def user_request(params)
    setup_email(params)

    @subject       = 'Nowe zapytanie'
    @body[:params] = params
  end

  protected
    def setup_email(params)
      @recipients  = "biuro@right-move.pl"
      @from        = params.email
      @sent_on     = Time.now
    end

end
