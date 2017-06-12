class AddIconToNewsitems < ActiveRecord::Migration[5.0]
  def change
    add_column :newsitems, :icon, :string
  end
end
