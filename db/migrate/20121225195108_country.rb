class Country < ActiveRecord::Migration
  def up

add_column :orders, :shipping_cost, :string
  end

  def down
  end
end
