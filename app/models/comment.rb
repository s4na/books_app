class Comment < ApplicationRecord
  belongs_to :book
  # belongs_to :report # report作るまでコメント化
end
