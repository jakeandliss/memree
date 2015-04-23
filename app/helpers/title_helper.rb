module TitleHelper

	def tag_links(tags)
	  tags.split(",").map{|tag| content_tag :li, link_to(tag.strip, tag_path(tag.strip))}.join("")
	end
	
end
