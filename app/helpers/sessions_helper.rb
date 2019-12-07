module SessionsHelper
      # Logs in the given user.
  def log_in(emcee)
    session[:emcee_id] = emcee.id
  end
end
