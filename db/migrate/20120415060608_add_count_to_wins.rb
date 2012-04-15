class AddCountToWins < ActiveRecord::Migration
  def change
    add_column :wins, :count, :integer

    add_index :wins, :count
  end
end
