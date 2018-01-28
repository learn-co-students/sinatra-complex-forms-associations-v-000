# Add seed data here. Seed your database with `rake db:seed`
sophie = Owner.create(name: "Sophie")
paul_and_elsie = Owner.create(name: "Paul and Elsie Miller")
Pet.create(name: "Maddy", owner: sophie)
Pet.create(name: "Nona", owner: sophie)
Pet.create(name: "Clancy", owner: paul_and_elsie)