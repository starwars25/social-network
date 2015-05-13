require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:admin)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should log in' do
    post :create, session: {email: @user.email, password: 'admin', remember_me: '0'}
    assert_redirected_to root_url
    assert is_logged_in?
  end

  test 'should not log in' do
    post :create, session: {email: @user.email, password: 'password', remember_me: '0'}
    assert_template 'sessions/new'
    assert_not is_logged_in?
  end

  test 'should log out' do
    log_in_as(@user, 'admin')
    delete :destroy
    assert_redirected_to root_url
    assert_not is_logged_in?
  end


end
