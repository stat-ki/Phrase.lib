class CreateSources < ActiveRecord::Migration[5.2]
  def change
    create_table :sources do |t|
      t.integer :category, null: false
      t.string :author, null: false
      t.string :title, null: false
      t.timestamps
    end
  end
end
