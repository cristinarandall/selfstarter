class AddOtherAmount < ActiveRecord::Migration
  def up


add_column :orders, :balance, :int
add_column :orders, :deposit, :int
  end

  def down
  end
end
