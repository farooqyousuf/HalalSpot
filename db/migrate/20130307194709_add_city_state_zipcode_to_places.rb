class AddCityStateZipcodeToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :city, :string
    add_column :places, :state, :string
    add_column :places, :zipcode, :integer
  end
end
