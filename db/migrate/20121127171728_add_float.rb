class AddFloat < ActiveRecord::Migration
  def up

change_column :orders, :balance, :float
change_column :orders, :deposit, :float

  end

  def down
  end
end
