class CreateMissions < ActiveRecord::Migration[5.0]
  def change
    create_table :missions do |t|
      t.string :name
      t.text :text
      t.integer :co2
      t.boolean :continuous
      t.references :category, index: true, foreign_key: true
      t.decimal :difficulty, precision: 3, scale: 2
      t.integer :duration, default: 0
      t.references :level, index: true, default: 1

      t.timestamps
    end
  end
end
