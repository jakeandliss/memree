class CreateTitles < ActiveRecord::Migration
  def change
    create_table :titles do |t|
      t.string :title
      t.date :title_date

      t.timestamps null: false
    end
  end
end
