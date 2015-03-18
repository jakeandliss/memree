class TitleController < ApplicationController

	def index
		@title = Title.all
	end

	def show
	end
end
