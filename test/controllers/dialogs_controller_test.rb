require 'test_helper'

class DialogsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @admin = users(:admin)
    @user_one = users(:user_one)
    @user_two = users(:user_two)
  end

  test 'should create dialog' do
    # get :user, id: @admin.id
    # assert_response :success
    # log_in_intergration(@admin)
    # assert is_logged_in?
    assert_difference 'Dialog.count', 1 do
      assert_difference 'DialogRelationship.count', 2 do
        post :create, from: @admin.id, to: @user_one.id
      end
    end
    assert flash[:success] == 'Dialog successfully created!'
    assert_redirected_to root_url
    # get :show, id: Dialog.last.id
    # assert_response :success
  end


end
