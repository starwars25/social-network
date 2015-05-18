require 'test_helper'

class DialogsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @admin = users(:admin)
    @user_one = users(:user_one)
    @user_two = users(:user_two)
    @dialog = dialogs(:one)
  end

  test 'should create dialog' do
    # get :user, id: @admin.id
    # assert_response :success
    # log_in_intergration(@admin)
    # assert is_logged_in?
    session[:user_id] = @admin.id
    assert_difference 'Dialog.count', 1 do
      assert_difference 'DialogRelationship.count', 2 do
        post :create, from: @admin.id, to: @user_one.id
      end
    end
    assert flash[:success] == 'Dialog successfully created!'
    assert_redirected_to Dialog.last
    # get :show, id: Dialog.last.id
    # assert_response :success
  end

  test 'should not be able to visit other dialogs' do
    session[:user_id] = @user_two.id
    get :show, id: @dialog.id
    assert_redirected_to root_url
  end


end
