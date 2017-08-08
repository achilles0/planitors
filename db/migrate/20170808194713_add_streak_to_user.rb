class AddStreakToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :post_score, :integer
    add_column :users, :streak_d, :integer
    add_column :users, :streak_w, :integer
    add_column :users, :streak_m, :integer
  end
end
