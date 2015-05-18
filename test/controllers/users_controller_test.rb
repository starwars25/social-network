require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:admin)
  end

  test 'sholud get sign up' do
    session[:user_id] = @user.id
    get :new
    assert_response :success
  end

  test 'should register' do
    session[:user_id] = @user.id
    assert_difference 'User.count', 1 do
      post :create, user: {username: 'foobar', email: 'foobar@foo.com', password: 'password', password_confirmation: 'password'}
    end
  end

  test 'should not register' do
    session[:user_id] = @user.id
    assert_no_difference 'User.count' do
      post :create, user: {username: '', email: '', password: 'password', password_confirmation: 'password'}
    end
    assert flash[:danger] == 'Input is invalid.'
    assert_template 'users/new'
  end

end
