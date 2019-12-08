module SessionsHelper

    # Logs in the given emcee.
    def log_in(emcee)
      session[:emcee_id] = emcee.id
    end
  
    # Returns the current logged-in emcee (if any).
    def current_emcee
      if session[:emcee_id]
        @current_emcee ||= Emcee.find_by(id: session[:emcee_id])
      end
    end

    def logged_in?
        !current_emcee.nil?
    end

    def log_out
        session.delete(:emcee_id)
        @current_emcee = nil
      end
  end
