class AddEntryAttributesToTitles < ActiveRecord::Migration
  def change
    add_column :titles, :entry, :string
  end
end
