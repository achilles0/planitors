class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :to_user_id
      t.integer :from_user_id
      t.string :subject
      t.string :text
      t.datetime :sent_at
      t.datetime :read_at

      t.timestamps
    end
  end
end
