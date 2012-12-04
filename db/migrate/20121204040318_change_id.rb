class ChangeId < ActiveRecord::Migration
  def up
change_column :items, :order_id, :string
  end

  def down
  end
end
