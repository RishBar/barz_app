# frozen_string_literal: true

require 'test_helper'

class EmceeTest < ActiveSupport::TestCase
  def setup
    @emcee = Emcee.new(name: 'Example emcee', email: 'emcee@example.com', password: 'imabeast1234')
  end

  test 'should be valid' do
    assert @emcee.valid?
  end

  test 'name should be present' do
    @emcee.name = '     '
    assert_not @emcee.valid?
  end

  test 'email should be present' do
    @emcee.email = '     '
    assert_not @emcee.valid?
  end

  test 'name should not be too long' do
    @emcee.name = 'a' * 51
    assert_not @emcee.valid?
  end

  test 'email should not be too long' do
    @emcee.email = 'a' * 244 + '@example.com'
    assert_not @emcee.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @emcee.email = valid_address
      assert @emcee.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @emcee.email = invalid_address
      assert_not @emcee.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email address should be unique' do
    duplicate_emcee = @emcee.dup
    duplicate_emcee.email = @emcee.email.upcase
    @emcee.save
    assert_not duplicate_emcee.valid?
  end

  test "authenticated? should return false for a emcee with nil digest" do
    assert_not @emcee.authenticated?(:remember, '')
  end
end
