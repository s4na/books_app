# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :report
end
