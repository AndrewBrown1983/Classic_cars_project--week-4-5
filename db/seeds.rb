require_relative('../models/car')
require_relative('../models/customer')
require_relative('../models/rental')
require('pry-byebug')

Car.delete_all()
Customer.delete_all()

car1 = Car.new({
  "type" => "1957 Ford Thunderbird",
  "rental_cost" => 500,
  "status" => "available"
  })

car1.save()

car2 = Car.new({
  "type" => "Aston Martin DB5",
  "rental_cost" => 550,
  "status" => "available"
      })

car2.save()

car3 = Car.new({
  "type" => "Mercedes Benz 300SL",
  "rental_cost" => 475,
  "status" => "available"
  })

car3.save()

car4 = Car.new({
  "type" => "1969 Camaro",
  "rental_cost" => 625,
  "status" => "unavailable"
  })

car4.save()

car5 = Car.new({
  "type" => "1969 Ford Mustang",
  "rental_cost" => 425,
  "status" => "available"
  })

car5.save()

car6 = Car.new({
  "type" => "Ferrari Enzo",
  "rental_cost" => 600,
  "status" => "available"
  })

car6.save()

customer1 = Customer.new({
  "name" => "Vince Vaughn",
  "address" => "7810 Bear Hill Court
  Fresno, CA 93727",
  "phone_number" => "111-345-894",
  "wallet" => 1500
  })

customer1.save()

customer2 = Customer.new({
  "name" => "Angelina Jolie",
  "address" => "642 Pin Oak Circle
  Lynwood, CA 90262",
  "phone_number" => "232-973-130",
  "wallet" => 2000
  })

customer2.save()

customer3 = Customer.new({
  "name" => "Val Kilmer",
  "address" => "2 Lawrence St.
  San Diego, CA 92154",
  "phone_number" => "454-421-989",
  "wallet" => 3500
  })

customer3.save()

customer4 = Customer.new({
  "name" => "John Cusack",
  "address" => "40 Marshall Drive
  Montebello, CA 90640",
  "phone_number" => "311-119-762",
  "wallet" => 1000
  })

customer4.save()

rental1 = Rental.new({
  "car_id" => car1.id,
  "customer_id" => customer1.id,
  "review" => "4 stars - very good experience. One of my favorite classics."
  })

rental1.save()

rental2 = Rental.new({
  "car_id" => car2.id,
  "customer_id" => customer3.id,
  "review" => "5 stars - Beautiful car. Felt like James Bond for a day!"
  })

rental2.save()

rental3 = Rental.new({
  "car_id" => car4.id,
  "customer_id" => customer2.id,
  "review" => "4 stars - it didn't disappoint!"
  })

rental3.save()

rental4 = Rental.new({
  "car_id" => car5.id,
  "customer_id" => customer1.id,
  "review" => "5 stars - awesome!"
  })

rental4.save()

rental5 = Rental.new({
  "car_id" => car6.id,
  "customer_id" => customer2.id,
  "review" => "5 stars - wow!"
  })

rental5.save()


  binding.pry
  nil
