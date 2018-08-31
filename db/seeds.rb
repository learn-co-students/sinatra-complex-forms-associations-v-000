# Add seed data here. Seed your database with `rake db:seed`
sophie = Owner.create(name: "Sophie")
robin = Owner.create(name: 'Robin')
Pet.create(name: "Maddy", owner: sophie)
Pet.create(name: "Nona", owner: sophie)
Pet.create(name: "Steven", owner: robin)
