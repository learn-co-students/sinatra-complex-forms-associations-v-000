# Add seed data here. Seed your database with `rake db:seed`
sophie = Owner.create(name: "Sophie")#owner class instance
Pet.create(name: "Maddy", owner: sophie)#pet class instance
Pet.create(name: "Nona", owner: sophie)#pet class instance

#many ways to seed your database (e.g. API)
