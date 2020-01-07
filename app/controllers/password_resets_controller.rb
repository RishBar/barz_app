class PasswordResetsController < ApplicationController
  before_action :get_emcee,   only: [:edit, :update]
  before_action :valid_emcee, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update] 

  def new
  end

  def create
    @emcee = Emcee.find_by(email: params[:password_reset][:email].downcase)
    if @emcee
      @emcee.create_reset_digest
      @emcee.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:emcee][:password].empty?                  # Case (3)
      @emcee.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @emcee.update(emcee_params)                     # Case (4)
      log_in @emcee
      flash[:success] = "Password has been reset."
      redirect_to @emcee
    else
      render 'edit'                                     # Case (2)
    end
  end

  private

  def emcee_params
    params.require(:emcee).permit(:password, :password_confirmation)
  end

  def get_emcee
    @emcee = Emcee.find_by(email: params[:email])
  end

  # Confirms a valid emcee.
  def valid_emcee
    unless (@emcee && @emcee.activated? &&
            @emcee.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  def check_expiration
    if @emcee.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_url
    end
  end

end
