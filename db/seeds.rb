# Add seed data here. Seed your database with `rake db:seed`
sophie = Owner.create(name: "Sophie")
Pet.create(name: "Maddy", owner: sophie)
Pet.create(name: "Nona", owner: sophie)

adam= Owner.create(name: "Adam")
Pet.create(name: "Garfield", owner: adam)
Pet.create(name: "Tigger", owner: adam)
