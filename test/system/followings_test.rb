# frozen_string_literal: true

require "application_system_test_case"

class FollowingsTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    @user = users(:test_user_1)
    login_as(@user, scope: :user)

    @book = books(:one)
  end

  test "show followings index" do
    visit "/followings/1"
    assert_selector "h1", text: "フォロー一覧"
  end
end
