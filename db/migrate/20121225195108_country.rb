class Country < ActiveRecord::Migration
  def up

change_column :orders, :shipping_cost, :float
  end

  def down
  end
end
