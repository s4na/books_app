# frozen_string_literal: true

require "test_helper"

class UserTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
    @user = users(:test_user_1)
    @other = users(:test_user_2)
    login_as(@user, scope: :user)
  end

  test "find_for_github_oauth" do
    auth = OmniAuth::AuthHash.new
    auth.define_singleton_method(:provider) do
      "github"
    end
    auth.define_singleton_method(:uid) do
      1
    end
    user = User.find_for_github_oauth(auth)
    assert_equal(users(:test_user_1), user)
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

  test "create_unique_stringで100個生成してもunieuq_stringが被らないことを確認" do
    unique_strings = []
    100.times do
      unique_strings.push(User.create_unique_string)
    end
    assert_equal(0, unique_strings.count - unique_strings.uniq.count)
  end

  test "dummy_email" do
    auth = OmniAuth::AuthHash.new
    auth.define_singleton_method(:provider) do
      "github"
    end
    auth.define_singleton_method(:uid) do
      1
    end
    email = User.dummy_email(auth)
    assert_equal(email, "#{auth.uid}-#{auth.provider}@example.com")
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
