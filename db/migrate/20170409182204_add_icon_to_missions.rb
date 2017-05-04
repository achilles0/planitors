class AddIconToMissions < ActiveRecord::Migration[5.0]
  def change
    add_column :missions, :icon, :string
  end
end
