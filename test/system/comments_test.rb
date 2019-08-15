# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
    @user = users(:test_user_1)
    login_as(@user, scope: :user)

    @book = books(:one)
  end

  test "index course" do
    visit books_url
    click_on "閲覧", match: :first
    assert_selector "h3", text: "コメント:"
  end

  test "create course" do
    visit books_url
    click_on "書籍を追加する"

    fill_in "タイトル", with: @book.title
    fill_in "メモ", with: @book.memo
    fill_in "作者", with: @book.author

    click_on "登録する"

    fill_in "comment_name", with: "コメント太郎"
    fill_in "comment_memo", with: "お腹が減りました"

    click_on "登録する"

    assert_text "コメントの作成に成功しました"
  end

  test "update course" do
    visit books_url
    click_on "書籍を追加する"

    fill_in "タイトル", with: @book.title
    fill_in "メモ", with: @book.memo
    fill_in "作者", with: @book.author
    click_on "登録する"

    fill_in "comment_name", with: "コメント太郎"
    fill_in "comment_memo", with: "お腹が減りました"
    click_on "登録する"

    click_on "編集", match: :first
    fill_in "名前", with: "更新後名前"
    fill_in "コメント", with: "更新後コメント"
    click_on "更新する"

    assert_text "コメントの更新に成功しました"
  end

  test "delete course" do
    visit books_url
    click_on "閲覧", match: :first

    fill_in "comment_name", with: "コメント太郎"
    fill_in "comment_memo", with: "お腹が減りました"

    click_on "登録する"

    page.accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "コメントの削除に成功しました"
  end
end
