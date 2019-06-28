class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :report
end
