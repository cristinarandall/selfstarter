class AddFloat < ActiveRecord::Migration
  def up

change_column :products, :price, :float
  end

  def down
  end
end
