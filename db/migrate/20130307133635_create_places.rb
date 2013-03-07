class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.string :description
      t.string :website
      t.string :category
      
      t.timestamps
    end
  end
end
