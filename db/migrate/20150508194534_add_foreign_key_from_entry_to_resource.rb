class AddForeignKeyFromEntryToResource < ActiveRecord::Migration
  def change
  	 add_reference :resources, :entry, index: true, foreign_key: true
  end
end
