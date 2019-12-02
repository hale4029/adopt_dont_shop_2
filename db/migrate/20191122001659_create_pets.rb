class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.binary :image
      t.string :name
      t.integer :approximate_age
      t.string :sex
      t.references :shelter, foreign_key: true
    end
  end
end
