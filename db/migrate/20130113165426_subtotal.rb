class Subtotal < ActiveRecord::Migration
  def up
add_column :orders, :subtotal, :float

  end

  def down
  end
end
