require 'rails_helper'

RSpec.describe Favorite do

  describe "#total_count" do
    it "can calculate the total number of pets it holds" do
      favorites = Favorite.new({
        1 => 1,
        2 => 1
      })
      expect(favorites.total_count).to eq(2)
    end
  end

  # describe "#add_pet" do
  #   it "adds a favorite to its contents" do
  #     favorites = Favorite.new({
  #       '1' => 1,
  #       '2' => 1
  #     })
  #     subject.add_pet(1)
  #     subject.add_pet(2)
  #
  #     expect(subject.contents).to eq({'1' => 2, '2' => 2})
  #   end
  #
  #   it "adds a song that hasn't been added yet" do
  #     subject.add_pet('3')
  #
  #     expect(subject.contents).to eq({'1' => 1, '2' => 1, '3' => 1})
  #   end
  # end

end
