require 'test_helper'

class NotificationsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:admin)
    @user_one = users(:user_one)
    @user_two = users(:user_two)
    @dialog = dialogs(:one)
  end

  test 'should send message and get notification' do
    Notification.all.each do |n|
      n.destroy
    end

    log_in_intergration(@admin, 'admin')
    assert is_logged_in?
    assert_difference '@user_one.notifications.count', 1 do
      xhr :post, messages_path, message: { user_id: @admin.id, dialog_id: @dialog.id, content: 'Lorem ipsum' }
    end
    assert @admin.notifications.count == 0
    assert @user_one.notifications.count == 1
    assert_no_difference '@user_one.notifications.count' do
      xhr :post, messages_path, message: { user_id: @admin.id, dialog_id: @dialog.id, content: 'Lorem ipsum' }
    end
    assert_difference '@user_one.notifications.count', 1 do
      post friend_requests_path, from_id: @admin.id, to_id: @user_one.id
    end

    friend_request = FriendRequest.last

    delete logout_path
    log_in_intergration(@user_two)
    assert_no_difference '@user_one.notifications.count' do
      post friend_requests_path, from_id: @admin.id, to_id: @user_two.id
    end
    delete logout_path
    log_in_intergration(@user_one)
    assert_difference '@user_one.notifications.count', -2 do
      xhr :get, dialog_path(@dialog.id)
      patch friend_request_path(friend_request), to_id: @user_one.id, from_id: @admin.id, friend_request: {choice: 'deny'}
    end
    assert @admin.notifications.count == 0
    assert @user_one.notifications.count == 0
  end
end
