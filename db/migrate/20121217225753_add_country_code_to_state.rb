class AddCountryCodeToState < ActiveRecord::Migration
  def change

add_column :states, :country_code, :string

  end
end
