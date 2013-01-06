class Country < ActiveRecord::Migration
  def up



add_column :orders, :total_discount, :float
  end

  def down
  end
end
