class CreateProduct < ActiveRecord::Migration
  def up

add_column :products, :price, :int
add_column :products, :description, :text

  end

  def down
  end
end
