# Add seed data here. Seed your database with `rake db:seed`
sophie = Owner.create(name: "Sophie")
greg = Owner.create(name: "Greg")
steve = Owner.create(name: "Steve")
Pet.create(name: "Maddy", owner: sophie)
Pet.create(name: "Nona", owner: sophie)
Pet.create(name: "Buzzy", owner: greg)
Pet.create(name: "Mr. Nippers", owner: steve)