class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :player1_id
      t.integer :player2_id
      t.string  :unique_id

      t.timestamps
    end
  end
end
