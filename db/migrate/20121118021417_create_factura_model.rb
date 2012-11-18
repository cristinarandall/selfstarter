class CreateFacturaModel < ActiveRecord::Migration
  def up


  create_table :posts do |t|
      t.integer :company_id
 
      t.timestamps
    end


  end

  def down
  end
end
