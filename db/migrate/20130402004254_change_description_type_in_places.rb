class ChangeDescriptionTypeInPlaces < ActiveRecord::Migration
  def up
    change_column :places, :description, :text, :limit => nil
  end

  def down
  end
end
