class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :entry
      t.belongs_to :title, index: true

      t.timestamps null: false
    end
  end
end
