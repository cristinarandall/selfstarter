class AddProductImageUrl < ActiveRecord::Migration
  def up

add_column :products, :image_url, :text
  end

  def down
  end
end
