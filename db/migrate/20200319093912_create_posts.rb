class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id, foregin_key: true, null: false
      t.integer :source_id, foregin_key: true
      t.string :phrase, null: false
      t.integer :language, null: false
      t.string :detail
      t.boolean :is_original, null: false
      t.boolean :is_sharing
      t.timestamps
    end
  end
end
