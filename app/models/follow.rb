# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: "User"

  validates :user_id, presence: true
  validates :follow_id, presence: true
end
