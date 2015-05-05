module TagsHelper
	def nested_tags(tags)
	  tags.map do |tag, sub_tags| 
	    render(tag) + content_tag(:div, nested_tags(sub_tags), :class => "nested_tags")
	  end.join.html_safe
	end
end
