class AddLastActiveAtToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :last_active_at, :datetime
  end
end
