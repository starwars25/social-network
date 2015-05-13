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
      post :create, user: {username: 'foobar', email: 'foobar@foo.com'}
    end
    assert flash[:success] == 'User successfully created.'
    assert_redirected_to root_url
  end

  test 'should not register' do
    assert_no_difference 'User.count' do
      post :create, user: {username: '', email: ''}
    end
    assert flash[:danger] == 'Input is invalid.'
    assert_template 'users/new'
  end

end
