ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :first_name, :last_name, :email, :created_at, :last_sign_in_at, :last_sign_in_ip
#
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
    column :first_name
    column :last_name
    column :email
    column 'Entries', sortable: :entries_count do |c|
        c.entries.count
    end
     column 'Last Entry', sortable: :entries_date do |c|
        t = c.entries.first
        unless t.nil?
            t.title_date.to_date.strftime('%b, %e, %Y')
    end
    end
    column :created_at
    column :last_sign_in_at
    column :sign_in_count
    actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end