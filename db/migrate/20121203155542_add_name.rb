class AddName < ActiveRecord::Migration
  def up

add_column :orders, :balance_paid, :boolean
add_column :orders, :deposit_paid, :boolean
add_column :orders, :deposit_payment_transaction_id, :string
  end

  def down
  end
end
