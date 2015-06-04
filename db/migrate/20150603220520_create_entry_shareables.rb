class CreateEntryShareables < ActiveRecord::Migration
  def change
    create_table :entry_shareables do |t|

      t.belongs_to :user, index: true
      t.belongs_to :entry, index: true

    end
  end
end
