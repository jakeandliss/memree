ActiveAdmin.register_page "Dashboard" do

menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

content title: proc{ I18n.t("active_admin.dashboard") } do
    section "Users" do
        table_for User.order("created_at desc").limit(10) do
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
        end
        strong { link_to "View All Users", admin_users_path}
    end
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
