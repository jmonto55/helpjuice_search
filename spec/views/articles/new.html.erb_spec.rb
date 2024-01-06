require 'rails_helper'

RSpec.describe "articles/new", type: :view do
  before(:each) do
    assign(:article, Article.new(
      title: "MyText",
      author: "MyText",
      content: "MyText"
    ))
  end

  it "renders new article form" do
    render

    assert_select "form[action=?][method=?]", articles_path, "post" do

      assert_select "textarea[name=?]", "article[title]"

      assert_select "textarea[name=?]", "article[author]"

      assert_select "textarea[name=?]", "article[content]"
    end
  end
end
