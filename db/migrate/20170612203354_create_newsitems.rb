class CreateNewsitems < ActiveRecord::Migration[5.0]
  def change
    create_table :newsitems do |t|
      t.string :name
      t.string :icon
      t.text :text
      t.references :level, index: true, default: 1

      t.timestamps
    end
  end
end
