class CreateGroupShareables < ActiveRecord::Migration
  def change
    create_table :group_shareables do |t|
      t.references :entry, index: true
      t.references :group, index: true

      t.timestamps null: false
    end
    add_foreign_key :group_shareables, :entries
    add_foreign_key :group_shareables, :groups
  end
end
