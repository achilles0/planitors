class ChangeMessageStringToText < ActiveRecord::Migration[5.0]
  def change
    change_column :messages, :text, :text
  end
end
