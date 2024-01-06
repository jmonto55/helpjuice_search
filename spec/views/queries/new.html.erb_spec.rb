require 'rails_helper'

RSpec.describe "queries/new", type: :view do
  before(:each) do
    assign(:query, Query.new(
      user_ip: "MyText",
      search: "MyText"
    ))
  end

  it "renders new query form" do
    render

    assert_select "form[action=?][method=?]", queries_path, "post" do

      assert_select "textarea[name=?]", "query[user_ip]"

      assert_select "textarea[name=?]", "query[search]"
    end
  end
end
