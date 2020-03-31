class AddColumnToSources < ActiveRecord::Migration[5.2]
  def change
    add_column :sources, :user_id, :integer, foregin_key: true
  end
end
