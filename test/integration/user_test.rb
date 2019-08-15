# frozen_string_literal: true

require "test_helper"

class FugaTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    @user = users(:test_user_1)
    @other = users(:test_user_2)
    login_as(@user, scope: :user)
  end

  test "update_without_current_passwordでパスワードなしでユーザー情報更新できることを確認" do
    @user.update_without_current_password(
      "email": "appletea.umauma@gmail.com",
      "name": "s4na",
      "postal_code": "111-1111",
      "street_address": "",
      "self_introduction": "")
    assert_equal("111-1111", @user.postal_code)
  end

  test "正常にfollowできることを確認" do
    before_follows_num = @user.follows.count
    @user.follow(@other)
    after_follows_num = @user.follows.count

    assert_equal(before_follows_num, after_follows_num - 1)
  end

  test "正常にunfollowできることを確認" do
    @user.follow(@other)

    before_follows_num = @user.follows.count
    @user.unfollow(@other)
    after_follows_num = @user.follows.count

    assert_equal(before_follows_num, after_follows_num + 1)
  end

  test "正常にfollowing?できることを確認" do
    @user.follow(@other)
    assert @user.following?(@other)
  end
end
