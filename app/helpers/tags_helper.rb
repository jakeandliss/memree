module TagsHelper
	def nested_tags(messages)
	  messages.map do |message, sub_messages|
	    render(message) + content_tag(:div, nested_tags(sub_messages), :class => "nested_messages")
	  end.join.html_safe
	end
end
