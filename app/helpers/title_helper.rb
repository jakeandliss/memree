module TitleHelper

	def tag_links(tags)
	  tags.split(",").map{|tag| link_to tag.strip, tag_path(tag.strip) }.join(", ") 
	end


=begin
	
rescue Exception => e
	
end	def link_to_add_entry(name, f, association) 
		new_object = f.object.send(association).klass.new
	id = new.object.object_id
	fields = f.fields_for(association, new_object, child_index: id) do |builder|
		render(association.to_s.singularize + "_fields", f: builder)
	end
	link_to(name, '#', class: "add_fields", data: {iod: id, fields: fields.gsub("\n", "")})
=end
end
