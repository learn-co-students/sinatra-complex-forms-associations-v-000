# Add seed data here. Seed your database with `rake db:seed`
sophie = Owner.create(name: "Sophie")
# mary_nelson = Owner.create(name: "Mary Nelson")
Pet.create(name: "Maddy", owner: sophie)
Pet.create(name: "Nona", owner: sophie)
