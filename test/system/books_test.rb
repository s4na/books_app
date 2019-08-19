# frozen_string_literal: true

require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
    @user = users(:test_user_1)
    login_as(@user, scope: :user)

    @book = books(:one)
  end

  test "show books index" do
    visit books_url
    assert_selector "h1", text: "書籍"
  end

  test "create book" do
    visit books_url
    click_on "書籍を追加する"

    fill_in "タイトル", with: @book.title
    fill_in "メモ", with: @book.memo
    fill_in "作者", with: @book.author
    attach_file "写真", "test/storage/images/book.png"
    click_on "登録する"

    assert_text "書籍の作成に成功しました"
  end

  test "update book" do
    visit books_url
    click_on "編集", match: :first

    fill_in "タイトル", with: "変更後タイトル"
    fill_in "メモ", with: "変更後メモ"
    fill_in "作者", with: "変更後作者"
    attach_file "写真", "test/storage/images/book_open_yoko.png"
    click_on "更新する"

    assert_text "書籍の更新に成功しました"
  end

  test "delete book" do
    visit books_url
    page.accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "書籍の削除に成功しました"
  end
end
