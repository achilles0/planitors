class CreateAcceptedMissions < ActiveRecord::Migration[5.0]
  def change
    create_table :accepted_missions do |t|
      t.references :user, foreign_key: true
      t.references :mission, foreign_key: true
      t.boolean :finished

      t.timestamps
    end

    add_index :accepted_missions, [:user_id, :mission_id], name: "user_missions_index", using: :btree
  end
end
