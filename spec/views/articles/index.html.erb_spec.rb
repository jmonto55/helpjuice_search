require 'rails_helper'

RSpec.describe "articles/index", type: :view do
  before(:each) do
    assign(:articles, [
      Article.create!(
        title: "MyText",
        author: "MyText",
        content: "MyTextMyTextMyTextMyText"
      ),
      Article.create!(
        title: "MyText",
        author: "MyText",
        content: "MyTextMyTextMyTextMyText"
      )
    ])
  end

  it "renders a list of articles" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 0
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 0
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 0
  end
end
