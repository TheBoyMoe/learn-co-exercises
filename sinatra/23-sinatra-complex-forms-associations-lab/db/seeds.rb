# Add seed data here. Seed your database with `rake db:seed`
sophie = Owner.create(name: "Sophie")
claire = Owner.create(name: "Claire")
Pet.create(name: "Maddy", owner: sophie)
Pet.create(name: "Nona", owner: sophie)
Pet.create(name: 'Max', owner: claire)
Pet.create(name: 'Fido', owner: claire)
Pet.create(name: 'Rex', owner: claire)
