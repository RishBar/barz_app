require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @emcee = emcees(:two)
    remember(@emcee)
  end

  test "current_emcee returns right emcee when session is nil" do
    assert_equal @emcee, current_emcee
    assert is_logged_in?
  end

  test "current_emcee returns nil when remember digest is wrong" do
    @emcee.update_attribute(:remember_digest, Emcee.digest(Emcee.new_token))
    assert_nil current_emcee
  end
end
