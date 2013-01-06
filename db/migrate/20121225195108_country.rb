class Country < ActiveRecord::Migration
  def up



remove_column :orders, :shipping_cost
add_column :orders, :shipping_cost, :float
  end

  def down
  end
end
