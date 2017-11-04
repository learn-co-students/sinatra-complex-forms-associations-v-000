# Add seed data here. Seed your database with `rake db:seed`
sophie = Owner.create(name: "Sophie")
adam = Owner.create(name: "Adam")
Pet.create(name: "Maddy", owner: sophie)
Pet.create(name: "Nona", owner: adam)
