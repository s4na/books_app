# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :comments
  mount_uploader :picture, PictureUploader
end
