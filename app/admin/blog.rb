ActiveAdmin.register Blog do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :title, :body
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
index do
	selectable_column
    id_column
    column :title
    column :body
    column :created_at
    actions
end

form do |f|
    f.inputs "Blog Details" do
      f.input :title
      f.input :body
    end
    f.actions
  end
end
