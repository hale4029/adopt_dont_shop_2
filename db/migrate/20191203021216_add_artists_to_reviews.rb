class AddArtistsToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :shelter, :reference
  end
end
