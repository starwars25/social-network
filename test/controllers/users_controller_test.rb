require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'sholud get sign up' do
    get :new
    assert_response :success
  end

  test 'should register' do
    assert_difference 'User.count', 1 do
      post :create, user: {username: 'foobar', email: 'foobar@foo.com', password: 'password', password_confirmation: 'password'}
    end
  end

  test 'should not register' do
    assert_no_difference 'User.count' do
      post :create, user: {username: '', email: '', password: 'password', password_confirmation: 'password'}
    end
    assert flash[:danger] == 'Input is invalid.'
    assert_template 'users/new'
  end

end
