require 'rails_helper'

RSpec.describe "articles/edit", type: :view do
  let(:article) {
    Article.create!(
      title: "MyText",
      author: "MyText",
      content: "MyText"
    )
  }

  before(:each) do
    assign(:article, article)
  end

  it "renders the edit article form" do
    render

    assert_select "form[action=?][method=?]", article_path(article), "post" do

      assert_select "textarea[name=?]", "article[title]"

      assert_select "textarea[name=?]", "article[author]"

      assert_select "textarea[name=?]", "article[content]"
    end
  end
end
