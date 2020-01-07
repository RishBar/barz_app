require 'test_helper'

class EmceeMailerTest < ActionMailer::TestCase
  test "account_activation" do
    emcee = emcees(:one)
    emcee.activation_token = Emcee.new_token
    mail = EmceeMailer.account_activation(emcee)
    assert_equal "Account activation", mail.subject
    assert_equal [emcee.email], mail.to
    assert_equal ["noreply@barz.com"], mail.from
    assert_match emcee.name,               mail.body.encoded
    assert_match emcee.activation_token,   mail.body.encoded
    assert_match CGI.escape(emcee.email),  mail.body.encoded
  end

  test "password_reset" do
    emcee = emcees(:one)
    emcee.reset_token = Emcee.new_token
    mail = EmceeMailer.password_reset(emcee)
    assert_equal "Password reset", mail.subject
    assert_equal [emcee.email], mail.to
    assert_equal ["noreply@barz.com"], mail.from
    assert_match emcee.reset_token,        mail.body.encoded
    assert_match CGI.escape(emcee.email),  mail.body.encoded
  end

end
