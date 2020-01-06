# Preview all emails at http://localhost:3000/rails/mailers/emcee_mailer
class EmceeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/emcee_mailer/account_activation
  def account_activation
    emcee = Emcee.first
    emcee.activation_token = Emcee.new_token
    EmceeMailer.account_activation(emcee)
  end

  # Preview this email at http://localhost:3000/rails/mailers/emcee_mailer/password_reset
  def password_reset
    EmceeMailer.password_reset
  end

end
