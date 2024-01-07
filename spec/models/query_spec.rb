require 'rails_helper'

RSpec.describe Query, type: :model do
  describe "most_popular_search method" do
    it "returns the most popular search term" do
      Query.create(search: "Ruby", user_ip: "192.168.1.1")
      Query.create(search: "Rails", user_ip: "192.168.1.2")
      Query.create(search: "Ruby", user_ip: "192.168.1.3")

      result = Query.most_popular_search

      expect(result).to eq("Ruby")
    end
  end

  describe "most_frequent_user method" do
    it "returns the most frequent user IP" do
      Query.create(search: "Ruby", user_ip: "192.168.1.1")
      Query.create(search: "Rails", user_ip: "192.168.1.1")
      Query.create(search: "Python", user_ip: "192.168.1.2")

      result = Query.most_frequent_user

      expect(result).to eq("192.168.1.1")
    end
  end
end
