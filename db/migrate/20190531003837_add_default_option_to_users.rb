class AddDefaultOptionToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_default, :boolean
  end
end
