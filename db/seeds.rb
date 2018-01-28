# Add seed data here. Seed your database with `rake db:seed`
sophie = Owner.create(name: "Sophie")
Pet.create(name: "Maddy", owner: sophie)
Pet.create(name: "Nona", owner: sophie)

sandy = Owner.create(name: "Sandy")
Pet.create(name: "Oreo", owner: sandy)
Pet.create(name: "Spencer", owner: sandy)

jamie = Owner.create(name: "Jamie")
Pet.create(name: "Sawyer", owner: jamie)
Pet.create(name: "Maggie", owner: jamie)
