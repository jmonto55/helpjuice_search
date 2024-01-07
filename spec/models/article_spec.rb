require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "article_count method" do
    it "returns the correct count of articles" do
      Article.create(title: "Title 1", author: "Author 1", content: "Content 1" * 20)
      Article.create(title: "Title 2", author: "Author 2", content: "Content 2" * 20)

      count = Article.article_count

      expect(count).to eq(2)
    end
  end
end
