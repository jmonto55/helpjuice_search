require 'rails_helper'

RSpec.describe "queries/edit", type: :view do
  let(:query) {
    Query.create!(
      user_ip: "MyText",
      search: "MyText"
    )
  }

  before(:each) do
    assign(:query, query)
  end

  it "renders the edit query form" do
    render

    assert_select "form[action=?][method=?]", query_path(query), "post" do

      assert_select "textarea[name=?]", "query[user_ip]"

      assert_select "textarea[name=?]", "query[search]"
    end
  end
end
