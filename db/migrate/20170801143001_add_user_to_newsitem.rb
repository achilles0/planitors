class AddUserToNewsitem < ActiveRecord::Migration[5.0]
  def change
    add_column :newsitems, :created_by, :integer
  end
end
