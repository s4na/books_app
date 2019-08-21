# frozen_string_literal: true

require "application_system_test_case"

class FollowersTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
    @user = users(:test_user_1)
    login_as(@user, scope: :user)

    @book = books(:one)
  end

  test "show followers index" do
    visit "/followers/1"
    assert_selector "h1", text: "フォロワー一覧"
  end
end
