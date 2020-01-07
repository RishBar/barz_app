require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @emcee = emcees(:one)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    assert_select 'input[name=?]', 'password_reset[email]'
    # Invalid email
    post password_resets_path, params: { password_reset: { email: "" } }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # Valid email
    post password_resets_path,
         params: { password_reset: { email: @emcee.email } }
    assert_not_equal @emcee.reset_digest, @emcee.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    # Password reset form
    emcee = assigns(:emcee)
    # Wrong email
    get edit_password_reset_path(emcee.reset_token, email: "")
    assert_redirected_to root_url
    # Inactive emcee
    emcee.toggle!(:activated)
    get edit_password_reset_path(emcee.reset_token, email: emcee.email)
    assert_redirected_to root_url
    emcee.toggle!(:activated)
    # Right email, wrong token
    get edit_password_reset_path('wrong token', email: emcee.email)
    assert_redirected_to root_url
    # Right email, right token
    get edit_password_reset_path(emcee.reset_token, email: emcee.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", emcee.email
    # Invalid password & confirmation
    patch password_reset_path(emcee.reset_token),
          params: { email: emcee.email,
                    emcee: { password:              "foobaz",
                            password_confirmation: "barquux" } }
    assert_select 'div#error_explanation'
    # Empty password
    patch password_reset_path(emcee.reset_token),
          params: { email: emcee.email,
                    emcee: { password:              "",
                            password_confirmation: "" } }
    assert_select 'div#error_explanation'
    # Valid password & confirmation
    patch password_reset_path(emcee.reset_token),
          params: { email: emcee.email,
                    emcee: { password:              "foobaz12345",
                            password_confirmation: "foobaz12345" } }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to emcee
  end
end
