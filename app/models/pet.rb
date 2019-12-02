class Pet < ApplicationRecord
  belongs_to :shelter

  validates_presence_of :image,
                        :name,
                        :approximate_age,
                        :sex,
                        :adoption_status,
                        :description
end
