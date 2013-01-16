class AddSecondary < ActiveRecord::Migration
  def up


add_column :orders, :secondary_phone, :string
add_column :orders, :secondary_email, :string
  end

  def down
  end
end
