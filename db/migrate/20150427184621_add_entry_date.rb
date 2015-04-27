class AddEntryDate < ActiveRecord::Migration
  def change
  	add_column :entries, :entry_date, :date
  end
end
