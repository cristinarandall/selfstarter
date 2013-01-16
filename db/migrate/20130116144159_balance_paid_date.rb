class BalancePaidDate < ActiveRecord::Migration
  def up

add_column :orders, :balance_paid_date, :datetime
  end

  def down
  end
end
