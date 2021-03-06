ApplicationPet.destroy_all
Shelter.destroy_all
Pet.destroy_all
Application.destroy_all

 @shelter_1 = Shelter.create(name:    "Reptile Room",
                             address: "2364 Desert Lane",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80211")
 @shelter_2 = Shelter.create(name:    "Fish Farm",
                             address: "8473 Ocean Drive",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80232")
 @shelter_3 = Shelter.create(name:    "The Aviary",
                             address: "27 Skylark Drive",
                             city:    "Denver",
                             state:   "CO",
                             zip:     "80215")

 @pet_1 = Pet.create(image:      "https://www.lllreptile.com/uploads/images/StoreInventoryImage/14570/large",
                     name:       "Alfredo",
                     description:       "I'm a white ball python!",
                     approximate_age:        "4",
                     sex:        "female",
                     shelter_id: @shelter_1.id)
 @pet_2 = Pet.create(image:     "https://www.geek.com/wp-content/uploads/2019/04/pantherchameleon1-625x352.jpg",
                    name:       "Poppy",
                    description:       "I'm a panther chameleon! I am not very social but am fun to look at.",
                    approximate_age:        "2",
                    sex:        "male",
                    shelter_id: @shelter_1.id)
 @pet_3 = Pet.create(image:      "https://localtvwiti.files.wordpress.com/2016/06/thinkstockphotos-528306066.jpg?quality=85&strip=all&w=400&h=225&crop=1",
                     name:       "Betsy",
                     description:       "I'm a blue tang fish. You might recognize me from the movie 'Finding Nemo'! I require a salt water tank.",
                     approximate_age:        "1",
                     sex:        "female",
                     shelter_id: @shelter_2.id)
 @pet_4 = Pet.create(image: "http://reptile.guide/wp-content/uploads/2019/02/Bearded-dragon-poop-.jpg",
                     name:  'Chive',
                     description:  "I'm a bearded dragon. I like to hunt and be active during the daytime.",
                     approximate_age: '5',
                     sex: 'male',
                     shelter_id: @shelter_1.id)
 @pet_5 = Pet.create(image: "https://lafeber.com/pet-birds/wp-content/uploads/2018/06/Lovebird-300x300.jpg",
                     name: 'Charlene',
                     description: "I'm a lonely lovebird looking for a new home.",
                     approximate_age: '3',
                     sex: 'female',
                     shelter_id: @shelter_3.id)
 @pet_6 = Pet.create(image: "https://d17fnq9dkz9hgj.cloudfront.net/uploads/2012/11/153546296-items-dangerous-pet-birds.jpg",
                     name: 'Zoe',
                     description: "I'm smart and sassy. Watch out.",
                     approximate_age: '8',
                     sex: 'female',
                     shelter_id: @shelter_3.id)
 @pet_7 = Pet.create(image: "https://storage.makerist.de/uploads/orderable_image/226835/image/carousel_large_image_a0dd000d.jpg",
                     name: 'Fancy',
                     description: "I'm a starfish looking for a saltwater home.",
                     approximate_age: '5',
                     sex: 'female',
                     shelter_id: @shelter_2.id)
 @pet_8 = Pet.create(image: "https://m.liveaquaria.com/images/categories/large/lg80188OcellarisClownfish.jpg",
                     name: 'Pumpkin',
                     description: "No, I was not in 'Finding Nemo' and yes, I am the same type of fish.",
                     approximate_age: '3',
                     sex: 'male',
                     shelter_id: @shelter_2.id)

@review_1 = Review.create(title: "Great experience!",
                          rating: 5,
                          content: "I got a snake from here and he is wonderful.",
                          picture: "https://www.virginiamercury.com/wp-content/uploads/2019/04/garter400.jpg",
                          shelter_id: @shelter_1.id)

@review_2 = Review.create(title: "This place sucks.",
                          rating: 2,
                          content: "Filthy animals",
                          shelter_id: @shelter_1.id)

@review_3 = Review.create(title: "Love this shelter!",
                          rating: 4,
                          content: "Customer service could have been better, but overall good experience.",
                          shelter_id: @shelter_2.id)
