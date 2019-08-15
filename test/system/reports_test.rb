# frozen_string_literal: true

require "application_system_test_case"
require "./test/helpers/date_time_select_helpers"

class ReportsTest < ApplicationSystemTestCase
  include Warden::Test::Helpers
  include Features::DateTimeSelectHelpers

  setup do
    Warden.test_mode!
    @user = users(:test_user_1)
    login_as(@user, scope: :user)

    @report = reports(:one)
  end

  test "index course" do
    visit reports_url
    assert_selector "h1", text: "日報"
  end

  test "create course" do
    visit reports_url
    click_on "新しい日報"

    fill_in "タイトル", with: @report.title
    fill_in "気分", with: @report.emotion
    fill_in "内容", with: @report.body
    fill_in "作者", with: @report.author

    select_date_and_time(@report.datetime, from: "report_datetime")

    click_on "登録する"

    assert_text "日報の作成に成功しました"
    click_on "戻る"
  end

  test "update course" do
    visit reports_url
    click_on "編集", match: :first

    fill_in "タイトル", with: "変更後タイトル"
    fill_in "気分", with: "変更後気分"
    fill_in "内容", with: "変更後内容"
    fill_in "作者", with: "変更後作者"
    click_on "更新する"

    assert_text "日報の更新に成功しました"
    click_on "戻る"
  end

  test "delete course" do
    visit reports_url
    page.accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "日報の削除に成功しました"
  end
end
