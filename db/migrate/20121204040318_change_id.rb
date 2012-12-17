class ChangeId < ActiveRecord::Migration
  def up
change_column :order, :balance_payment_transaction_id, :string

  end

  def down
  end
end
