class TotalOrder < ActiveRecord::Migration
  def up

add_column :orders, :total, :float
  end

  def down
  end
end
