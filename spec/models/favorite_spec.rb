require 'rails_helper'

RSpec.describe Favorite do

  describe "#total_count" do
    it "can calculate the total number of pets it holds" do
      favorites = Favorite.new({
        '1' => 1,
        '2' => 1
      })
      expect(favorites.total_count).to eq(2)

      favorites.add_pet(3)

      expect(favorites.contents).to eq({'1' => 1, '2' => 1, '3' => 1})
    end

    it "cannot add a pet more than once to favorites" do
      favorites = Favorite.new({
        '1' => 1,
        '2' => 1
      })
      expect(favorites.total_count).to eq(2)

      favorites.add_pet(1)
      favorites.add_pet(2)

      expect(favorites.contents).to eq({'1' => 1, '2' => 1})
    end

  end

end
