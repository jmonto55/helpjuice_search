require 'rails_helper'

RSpec.describe "queries/index", type: :view do
  before(:each) do
    assign(:queries, [
      Query.create!(
        user_ip: "MyText",
        search: "MyText"
      ),
      Query.create!(
        user_ip: "MyText",
        search: "MyText"
      )
    ])
  end

  it "renders a list of queries" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 4
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 4
  end
end
