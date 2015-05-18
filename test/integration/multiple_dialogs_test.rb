require 'test_helper'

class MultipleDialogsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @admin = users(:admin)
    @user_one = users(:user_one)
    @user_two = users(:user_two)
  end

  test 'create multidialog' do
    log_in_intergration @admin, 'admin'
    assert is_logged_in?
    assert_difference 'Dialog.count', 1 do
      post dialogs_path, multi: true, dialog: { string: "#{@user_one.email} #{@user_two.email}", creator_id: @admin.id, name: 'Test' }
    end
    dialog = Dialog.last
    assert dialog.name == 'Test'
    assert dialog.members.count == 3
    assert dialog.members.include? @admin
    assert dialog.members.include? @user_one
    assert dialog.members.include? @user_two
    assert @admin.dialogs.include? dialog
    assert @user_one.dialogs.include? dialog
    assert @user_two.dialogs.include? dialog
  end
end
