require 'test_helper'

class DialogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @admin = users(:admin)
    @user_one = users(:user_one)
    @user_two = users(:user_two)
  end

  test 'create dialog' do
    assert_difference 'Dialog.count', 1 do
      @dialog = Dialog.create(name: 'Test dialog')
    end
    @dialog.add_member(@admin)
    @dialog.add_member(@user_one)
    @dialog.add_member(@user_two)
    assert @dialog.members.count == 3
    assert @dialog.has_member?(@admin)
    assert @dialog.has_member?(@user_one)
    assert @dialog.has_member?(@user_two)
    assert @admin.is_member_of(@dialog)
    assert @user_one.is_member_of(@dialog)
    assert @user_two.is_member_of(@dialog)
    @dialog.remove_member(@admin)
    assert_not @dialog.has_member?(@admin)
    assert @dialog.has_member?(@user_one)
    assert @dialog.has_member?(@user_two)
    assert_not @admin.is_member_of(@dialog)
    assert @user_one.is_member_of(@dialog)
    assert @user_two.is_member_of(@dialog)
    assert @dialog.members.count == 2
  end

  test 'has dialog with' do
    assert_difference 'Dialog.count', 1 do
      @dialog = Dialog.create(name: 'Test dialog')
    end
    @dialog.add_member(@admin)
    @dialog.add_member(@user_one)
    assert @dialog.members.count == 2
    assert @admin.has_dialog_with(@user_one)
    assert @user_one.has_dialog_with(@admin)
  end
end
