require 'rails_helper'

RSpec.describe "queries/show", type: :view do
  before(:each) do
    assign(:query, Query.create!(
      user_ip: "MyText",
      search: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
