class CreateProductsSecond < ActiveRecord::Migration
  def up
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :price

      t.timestamps
    end
  end

  def down
  end
end
