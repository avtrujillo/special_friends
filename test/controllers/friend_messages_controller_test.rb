require 'test_helper'

class FriendMessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @friend_message = friend_messages(:one)
  end

  test "should get index" do
    get friend_messages_url
    assert_response :success
  end

  test "should get new" do
    get new_friend_message_url
    assert_response :success
  end

  test "should create friend_message" do
    assert_difference('FriendMessage.count') do
      post friend_messages_url, params: { friend_message: { content: @friend_message.content, friend_match_id: @friend_message.friend_match_id, recipient_id: @friend_message.recipient_id, sender_id: @friend_message.sender_id } }
    end

    assert_redirected_to friend_message_url(FriendMessage.last)
  end

  test "should show friend_message" do
    get friend_message_url(@friend_message)
    assert_response :success
  end

  test "should get edit" do
    get edit_friend_message_url(@friend_message)
    assert_response :success
  end

  test "should update friend_message" do
    patch friend_message_url(@friend_message), params: { friend_message: { content: @friend_message.content, friend_match_id: @friend_message.friend_match_id, recipient_id: @friend_message.recipient_id, sender_id: @friend_message.sender_id } }
    assert_redirected_to friend_message_url(@friend_message)
  end

  test "should destroy friend_message" do
    assert_difference('FriendMessage.count', -1) do
      delete friend_message_url(@friend_message)
    end

    assert_redirected_to friend_messages_url
  end
end
