class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :rating
      t.string :content
      t.string :picture, default: "https://sterlingcomputers.com/wp-content/themes/Sterling/images/no-image-found-360x260.png"
      t.references :shelter, foreign_key: true

      t.timestamps
    end
  end
end
