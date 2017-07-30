class AddReadnewsitemsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :readnewsitems, :string
  end
end
