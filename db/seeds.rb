# Add seed data here. Seed your database with `rake db:seed`
sophie = Owner.create(name: "Sophie")
jackie = Owner.create(name: "Jackie")
ross = Owner.create(name: "Ross")
Pet.create(name: "Maddy", owner: sophie)
Pet.create(name: "Nona", owner: sophie)
Pet.create(name: "Fido", owner: ross)