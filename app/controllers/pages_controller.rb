class PagesController < ApplicationController

  def home
    @user = User.new
    render layout: "capture"
  end

  def about
  end
end
