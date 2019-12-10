# frozen_string_literal: true

require 'test_helper'

class EmceesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @emcee = emcees(:one)
  end

  test 'should get index' do
    get emcees_url
    assert_response :success
  end

  test 'should get new' do
    get new_emcee_url
    assert_response :success
  end

  test 'should create emcee' do
    assert_difference('Emcee.count') do
      post emcees_url, params: { emcee: { email: 'example2@example.com', name: @emcee.name, password: 'dude123456' } }
    end

    assert_redirected_to emcee_url(Emcee.last)
  end

  test 'should not create emcee if email is invalid' do
    assert_no_difference('Emcee.count') do
      post emcees_url, params: { emcee: { email: 'example2example.com', name: @emcee.name, password: 'dude123456' } }
    end
    assert_template 'new'
  end

  test 'should not create emcee if name is invalid' do
    assert_no_difference('Emcee.count') do
      post emcees_url, params: { emcee: { email: 'example2@example.com', name: '', password: 'dude123456' } }
    end
    assert_template 'new'
  end

  test 'should not create emcee if password is invalid' do
    assert_no_difference('Emcee.count') do
      post emcees_url, params: { emcee: { email: 'example2@example.com', name: @emcee.name, password: 'i' } }
    end
    assert_template 'new'
  end

  test 'should show emcee' do
    get emcee_url(@emcee)
    assert_response :success
  end

  test 'should get edit' do
    get edit_emcee_url(@emcee)
    assert_response :success
  end

  test 'should update emcee' do
    patch emcee_url(@emcee), params: { emcee: { email: @emcee.email, name: @emcee.name, password: 'dude123456' } }
    assert_redirected_to emcee_url(@emcee)
  end

  test 'should destroy emcee' do
    assert_difference('Emcee.count', -1) do
      delete emcee_url(@emcee)
    end

    assert_redirected_to emcees_url
  end
end
