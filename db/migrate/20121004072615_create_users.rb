class CreateUsers < ActiveRecord::Migration
  def up
    create_table :items do |t|
      t.string :quantity
      t.string :product_id
      t.integer :order_id

      t.timestamps
    end
  end

  def down
  end
end
