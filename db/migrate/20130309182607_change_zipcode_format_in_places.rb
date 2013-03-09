class ChangeZipcodeFormatInPlaces < ActiveRecord::Migration
  def up
    change_column :places, :zipcode, :string
  end

  def down
    change_column :places, :zipcode, :integer
  end
end
