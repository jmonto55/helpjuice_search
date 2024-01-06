class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }
  validates :author, presence: true, length: { minimum: 3 }
  validates :content, presence: true, length: { minimum: 20 }
end
