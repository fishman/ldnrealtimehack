class ChangeUsersEmailField < ActiveRecord::Migration
  def up
    change_column :users, :email, :string, :default => nil, :null => true
  end

  def down
  end
end
