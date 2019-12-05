require 'rails_helper'

RSpec.describe Favorite do

  describe "#total_count" do
    it "can calculate the total number of pets it holds" do
      favorites = Favorite.new({
        '1' => 1,
        '2' => 1
      })
      expect(favorites.total_count).to eq(2)
    end
  end

  describe "#add_pet" do
    it "adds a favorite to its contents" do
      favorites = Favorite.new({
        '1' => 1,
        '2' => 1
      })

      favorites.add_pet(1)
      favorites.add_pet(2)

      expect(favorites.contents).to eq({'1' => 2, '2' => 2})

      favorites.add_pet(3)

      expect(favorites.contents).to eq({'1' => 2, '2' => 2, '3' => 1})
    end
  end

end
