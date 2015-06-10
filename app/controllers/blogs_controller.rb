class BlogsController < InheritedResources::Base

	def index
		@blogs = Blog.all
	end

	def show
		@blog = Blog.friendly.find(params[:id])
	end

end

