# Add seed data here. Seed your database with `rake db:seed`
#creating and saving instances of our Owner and Pet class
sophie = Owner.create(name: "Sophie")
Pet.create(name: "Maddy", owner: sophie)
Pet.create(name: "Nona", owner: sophie)
