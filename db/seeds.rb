shelter_1 = Shelter.create(name: "Save Cats",
                          address: "123 Pine",
                          city: "Denver",
                          state: "Colorado",
                          zip: 80112)

shelter_2 = Shelter.create(name: "Save Dogs",
                          address: "134 Pine",
                          city: "Littleton",
                          state: "Colorado",
                          zip: 80111)

shelter_1.pets.create(image: 'https://www.petmd.com/sites/default/files/Acute-Dog-Diarrhea-47066074.jpg',
                  name: "Hershey",
                  approximate_age: 5,
                  sex: "Male")

shelter_2.pets.create(image: 'https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/09/dog-landing-hero-lg.jpg?bust=1536935129&width=1080',
                  name: "Jersey",
                  approximate_age: 10,
                  sex: "Male")

                  
