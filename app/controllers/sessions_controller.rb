class SessionsController < ApplicationController
  def new
  end

  def create
    emcee = Emcee.find_by(email: params[:session][:email].downcase)
    if emcee && emcee.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
    else
      flash[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
  end

end
