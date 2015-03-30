class PagesController < ApplicationController

  def home
    render layout: "capture"
    @user = User.new
  end

  def about
  end
end
