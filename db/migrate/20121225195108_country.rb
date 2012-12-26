class Country < ActiveRecord::Migration
  def up

add_column :orders, :gritworks, :string

  end

  def down
  end
end
