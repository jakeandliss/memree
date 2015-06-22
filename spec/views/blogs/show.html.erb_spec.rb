require 'rails_helper'

RSpec.describe "blogs/show", type: :view do
  before(:each) do
    @blog = assign(:blog, Blog.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
