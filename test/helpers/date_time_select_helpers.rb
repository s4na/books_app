# frozen_string_literal: true

# 参考: https://stackoverflow.com/questions/6729786/how-to-select-date-from-a-select-box-using-capybara-in-rails-3

module Features
  module DateTimeSelectHelpers
    def select_date_and_time(date, options = {})
      field = options[:from]

      select date.strftime("%Y"),  from: "#{field}_1i" # year
      select date.strftime("%-M"),  from: "#{field}_2i" # month
      select date.strftime("%-d"), from: "#{field}_3i" # day
      select date.strftime("%H"),  from: "#{field}_4i" # hour
      select date.strftime("%M"),  from: "#{field}_5i" # minute
    end
  end
end
