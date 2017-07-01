class CreateUserInterests < ActiveRecord::Migration[5.0]
  def change
    create_table :user_interests do |t|
      t.references :tag
      t.integer :weight

      t.timestamps
    end
  end
end
