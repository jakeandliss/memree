require 'rails_helper'

RSpec.describe "blogs/index", type: :view do
  before(:each) do
    assign(:blogs, [
      Blog.create!(),
      Blog.create!()
    ])
  end

  it "renders a list of blogs" do
    render
  end
end
