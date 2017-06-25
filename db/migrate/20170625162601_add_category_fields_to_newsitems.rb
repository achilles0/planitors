class AddCategoryFieldsToNewsitems < ActiveRecord::Migration[5.0]
  def change
    add_column :newsitems, :tags, :string
    add_column :newsitems, :bestbefore, :date
    add_column :newsitems, :relevancedays, :integer
    add_column :newsitems, :links, :string
  end
end
