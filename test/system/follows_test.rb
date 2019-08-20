# frozen_string_literal: true

require "application_system_test_case"

class FollowsTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    @user = users(:test_user_1)
    login_as(@user, scope: :user)

    @book = books(:one)
  end

  test "create follow" do
    visit users_url
    click_on "フォロー", match: :first

    assert_text "フォローの作成に成功しました"
  end

  test "delete follow" do
    visit users_url
    click_on "フォロー", match: :first

    click_on "フォロー中", match: :first

    assert_text "フォローの削除に成功しました"
  end
end
