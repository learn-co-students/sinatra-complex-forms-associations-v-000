# Add seed data here. Seed your database with `rake db:seed`
Owner.delete_all
Pet.delete_all
sophie = Owner.create(name: "Sophie")
Pet.create(name: "Maddy", owner: sophie)
Pet.create(name: "Nona", owner: sophie)