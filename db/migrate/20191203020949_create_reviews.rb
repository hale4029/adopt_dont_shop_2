class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :rating
      t.string :content
      t.binary :picture, default: nil
      t.references :shelter, foreign_key: true

      t.timestamps
    end
  end
end
