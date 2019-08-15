# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
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
end
