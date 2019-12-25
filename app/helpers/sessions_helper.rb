# frozen_string_literal: true

module SessionsHelper
  # Logs in the given emcee.
  def log_in(emcee)
    session[:emcee_id] = emcee.id
  end

  def remember(emcee)
    emcee.remember
    cookies.permanent.signed[:emcee_id] = emcee.id
    cookies.permanent[:remember_token] = emcee.remember_token
  end

  # Returns the current logged-in emcee (if any).
  def current_emcee
    if (emcee_id = session[:emcee_id])
      @current_emcee ||= Emcee.find_by(id: emcee_id)
    elsif (emcee_id = cookies.signed[:emcee_id])
      emcee = Emcee.find_by(id: emcee_id)
      if emcee && emcee.authenticated?(cookies[:remember_token])
        log_in emcee
        @current_emcee = emcee
      end
    end
  end

  def current_emcee?(emcee)
    emcee && emcee == current_emcee
  end

  def logged_in?
    !current_emcee.nil?
  end

  def forget(emcee)
    emcee.forget
    cookies.delete(:emcee_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_emcee)
    session.delete(:emcee_id)
    @current_emcee = nil
  end

    # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
  
    # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
