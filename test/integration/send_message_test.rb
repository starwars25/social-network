require 'test_helper'

class SendMessageTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @admin = users(:admin)
    @user_one = users(:user_one)
    @user_two = users(:user_two)
    @dialog = dialogs(:one)
  end

  test 'login and send' do
    log_in_intergration(@admin, 'admin')
    assert is_logged_in?
    xhr :get, dialog_path(@dialog.id)
    assert_template('dialogs/show')
    assert_difference 'Message.count', 1 do
      xhr :post, messages_path, message: { user_id: @admin.id, dialog_id: @dialog.id, content: 'Lorem ipsum' }
    end
    assert @dialog.messages.count == 1
    delete logout_path
    log_in_intergration(@user_two)
    assert is_logged_in?
    assert_no_difference 'Message.count', 1 do
      post messages_path, message: { user_id: @user_two.id, dialog_id: @dialog.id, content: 'Lorem ipsum' }
    end
    assert_redirected_to root_url
  end
end
