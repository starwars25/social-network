require 'test_helper'

class QuitDialogTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @admin = users(:admin)
    @user_one = users(:user_one)
    @user_two = users(:user_two)
    @user_three = users(:user_three)
    @dialog = dialogs(:two)
  end

  test 'should quit dialog' do
    log_in_intergration @user_two
    assert is_logged_in?
    assert_difference 'DialogRelationship.count', -1 do
      post quit_dialog_path, user_id: @user_two.id, dialog_id: @dialog.id
    end
    assert_redirected_to root_url
    assert @dialog.members.count == 2
    assert @dialog.members.include? @admin
    assert @dialog.members.include? @user_one
    assert_not @dialog.members.include? @user_two
    assert @admin.dialogs.include? @dialog
    assert @user_one.dialogs.include? @dialog
    assert_not @user_two.dialogs.include? @dialog
  end

  test 'should not quit dialog' do
    log_in_intergration @user_two
    assert is_logged_in?
    assert_no_difference 'DialogRelationship.count' do
      post quit_dialog_path, user_id: @user_three.id, dialog_id: @dialog.id
    end
    assert flash[:danger] == 'You are not a member of this dialog'
    assert_redirected_to root_url
  end
end
