class Query < ApplicationRecord
  validates :search, presence: true, length: { minimum: 3 }
  validates :user_ip, presence: true
end
