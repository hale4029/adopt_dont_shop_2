class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  validates_presence_of :image,
                        :name,
                        :approximate_age,
                        :sex,
                        :adoption_status,
                        :description
end
