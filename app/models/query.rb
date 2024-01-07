class Query < ApplicationRecord
  validates :search, presence: true, length: { minimum: 3 }
  validates :user_ip, presence: true

  def self.most_popular_search
    result = group(:search).order('count_search DESC').limit(1).count(:search)
    result.keys.first if result.present?
  end

  def self.most_frequent_user
    result = group(:user_ip).order('count_user_ip DESC').limit(1).count(:user_ip)
    result.keys.first if result.present?
  end
end
