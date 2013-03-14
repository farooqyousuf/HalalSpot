class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :reviewer
      t.text :body
      t.references :place

      t.timestamps
    end
    add_index :reviews, :place_id
  end
end
