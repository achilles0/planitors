class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.string :icon
      t.string :description

      t.timestamps
    end
    add_index :tags, :name
  end
end
