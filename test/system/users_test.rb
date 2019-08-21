# frozen_string_literal: true

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
    @user = users(:test_user_1)
    login_as(@user, scope: :user)

    @book = books(:one)
  end

  test "show users index" do
    visit users_url
    assert_selector "h1", text: "ユーザー"
  end

  test "show user" do
    visit "/users/1"
    assert_selector "h1", text: "プロフィール"
  end

  test "create user" do
    visit root_path
    click_on "ログアウト"
    click_on "サインアップ"

    fill_in "名前", with: "変更後名前"
    fill_in "メールアドレス", with: "change_test@test.com"
    attach_file "アイコン", "test/storage/images/animal_araiguma_side.png"
    fill_in "郵便番号", with: "111-1111"
    fill_in "住所", with: "千代田区1-1-1"
    fill_in "自己紹介", with: "変更後自己紹介"
    fill_in "パスワード", with: "testtest"
    fill_in "パスワード（確認用）", with: "testtest"

    # linkでも"サインアップ"があるため、click_buttonを使用
    click_button "サインアップ"

    assert_text "アカウント登録が完了しました。"
  end

  test "update user" do
    visit "/users/1"
    click_on "編集", match: :first

    fill_in "名前", with: "変更後名前"
    fill_in "メールアドレス", with: "change_test@test.com"
    attach_file "アイコン", "test/storage/images/animal_sable_antelope.png"
    fill_in "郵便番号", with: "111-1111"
    fill_in "住所", with: "千代田区1-1-1"
    fill_in "自己紹介", with: "変更後自己紹介"
    click_on "更新"

    assert_text "アカウント情報を変更しました"
  end

  test "delete user" do
    visit "/users/3"
    click_on "編集", match: :first
    page.accept_confirm do
      click_on "アカウント削除", match: :first
    end

    assert_text "アカウントを削除しました。またのご利用をお待ちしております。"
  end
end
