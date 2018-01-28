# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Dealership.create(name: "Ereve", city: "Lith Harbor")
Dealership.create(name: "Rien", city: "Ellinia")
Dealership.create(name: "Grandis", city: "Henesys")
Dealership.create(name: "Victoria", city: "Kerning City")
Dealership.create(name: "Maple", city: "Tree Hill")
Dealership.create(name: "Ossyria", city: "Southperry")

DealershipVehicle.create(dealership_id: 1, buyer: "Tom", price: 20999, is_lot_ready: false)
DealershipVehicle.create(dealership_id: 2, buyer: "Jon", price: 20999, is_lot_ready: false)
DealershipVehicle.create(dealership_id: 3, buyer: "Mike", price: 20999, is_lot_ready: false)
DealershipVehicle.create(dealership_id: 4, buyer: "Brandon", price: 20999, is_lot_ready: false)
DealershipVehicle.create(dealership_id: 5, buyer: "Jason", price: 20999, is_lot_ready: false)
DealershipVehicle.create(dealership_id: 6, buyer: "Daniel", price: 20999, is_lot_ready: false)
DealershipVehicle.create(dealership_id: 1, buyer: "Ali", price: 14999, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 2, buyer: "Nikola", price: 14999, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 3, buyer: "Chris", price: 14999, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 4, buyer: "Chance", price: 14999, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 5, buyer: "Marty", price: 14999, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 6, buyer: "Artur", price: 14999, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 1, buyer: "Karol", price: 9999, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 2, buyer: "Tim", price: 9999, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 3, buyer: "Luke", price: 9999, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 4, buyer: "George", price: 9999, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 5, buyer: "Jennifer", price: 9999, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 6, buyer: "LB", price: 9999, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 1, buyer: "CJ", price: 8999, is_lot_ready: false)
DealershipVehicle.create(dealership_id: 2, buyer: "Ross", price: 8999, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 3, buyer: "Dwight", price: 8999, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 4, buyer: "Jim", price: 8999, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 5, buyer: "Pam", price: 8999, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 6, buyer: "Nancy", price: 8999, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 1, buyer: "Oskar", price: 30099, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 2, buyer: "Satish", price: 30099, is_lot_ready: true)
DealershipVehicle.create(dealership_id: 3, buyer: "Philip", price: 30099, is_lot_ready: false)

Vehicle.create(make: "BMW", model: "M3", year: 2016, dealership_vehicle_id: 1)
Vehicle.create(make: "Toyota", model: "Corolla", year: 2016, dealership_vehicle_id: 2)
Vehicle.create(make: "Ford", model: "Escape", year: 2016, dealership_vehicle_id: 3)
Vehicle.create(make: "Chevrolet", model: "Malibu", year: 2016, dealership_vehicle_id: 4)
Vehicle.create(make: "Volkswagen", model: "Beetle", year: 2016, dealership_vehicle_id: 5)
Vehicle.create(make: "Volkswagen", model: "Caddy", year: 2010, dealership_vehicle_id: 6)
Vehicle.create(make: "Volkswagen", model: "Passat", year: 2010, dealership_vehicle_id: 7)
Vehicle.create(make: "Volkswagen", model: "Tiguan", year: 2010, dealership_vehicle_id: 8)
Vehicle.create(make: "BMW", model: "3 Series", year: 2010, dealership_vehicle_id: 9)
Vehicle.create(make: "BMW", model: "i8", year: 2010, dealership_vehicle_id: 10)
Vehicle.create(make: "BMW", model: "M6", year: 2015, dealership_vehicle_id: 11)
Vehicle.create(make: "BMW", model: "X3", year: 2015, dealership_vehicle_id: 12)
Vehicle.create(make: "Volvo", model: "S60", year: 2015, dealership_vehicle_id: 13)
Vehicle.create(make: "Volvo", model: "S80", year: 2015, dealership_vehicle_id: 14)
Vehicle.create(make: "Volvo", model: "V40", year: 2015, dealership_vehicle_id: 15)
Vehicle.create(make: "Volvo", model: "XC60", year: 2011, dealership_vehicle_id: 16)
Vehicle.create(make: "Nissan", model: "Altima", year: 2011, dealership_vehicle_id: 17)
Vehicle.create(make: "Nissan", model: "GT-R", year: 2011, dealership_vehicle_id: 18)
Vehicle.create(make: "Nissan", model: "Patrol", year: 2011, dealership_vehicle_id: 19)
Vehicle.create(make: "Nissan", model: "Micra", year: 2011, dealership_vehicle_id: 20)
Vehicle.create(make: "Nissan", model: "Navara", year: 2014, dealership_vehicle_id: 21)
Vehicle.create(make: "Honda", model: "Accord", year: 2014, dealership_vehicle_id: 22)
Vehicle.create(make: "Honda", model: "Civic", year: 2014, dealership_vehicle_id: 23)
Vehicle.create(make: "Honda", model: "Ridgeline", year: 2014, dealership_vehicle_id: 24)
Vehicle.create(make: "Honda", model: "Oddyssey", year: 2014, dealership_vehicle_id: 25)
Vehicle.create(make: "Kia", model: "Stinger", year: 2017, dealership_vehicle_id: 26)
Vehicle.create(make: "Kia", model: "Soul", year: 2017, dealership_vehicle_id: 27)

Employee.create(name: "Bill Gates", manager: true, email: "bill.gates@gmail.com", password: "password", dealership_id: 1, permission: 0)
Employee.create(name: "Mark Zuckerberg", manager: false, email: "mark.zuckerberg@gmail.com", password: "password", dealership_id: 2, permission: 0)
Employee.create(name: "Ada Lovelace", manager: false, email: "ada.lovelace@gmail.com", password: "password", dealership_id: 3, permission: 0)
Employee.create(name: "Steve Wozniak", manager: false, email: "steve.wozniak@gmail.com", password: "password", dealership_id: 4, permission: 0)
Employee.create(name: "John Carmack", manager: false, email: "john.carmack@gmail.com", password: "password", dealership_id: 5, permission: 0)
Employee.create(name: "Donald Knuth", manager: false, email: "donald.knuth@gmail.com", password: "password", dealership_id: 6, permission: 0)
Employee.create(name: "Grace Hopper", manager: true, email: "grace.hopper@gmail.com", password: "password", dealership_id: 2, permission: 0)
Employee.create(name: "Richard Stallman", manager: false, email: "richard.stallman@gmail.com", password: "password", dealership_id: 1, permission: 0)
Employee.create(name: "James Gosling", manager: false, email: "james.gosling@gmail.com", password: "password", dealership_id: 3, permission: 0)
Employee.create(name: "Ken Thompson", manager: false, email: "ken.thompson@gmail.com", password: "password", dealership_id: 4, permission: 0)
Employee.create(name: "Bjarne Stroustrup", manager: false, email: "bjarne.stroustrup@gmail.com", password: "password", dealership_id: 5, permission: 0)
Employee.create(name: "Larry Wall", manager: false, email: "larry.wall@gmail.com", password: "password", dealership_id: 6, permission: 0)
Employee.create(name: "Linus Torvalds", manager: true, email: "linus.torvalds@gmail.com", password: "password", dealership_id: 3, permission: 0)
Employee.create(name: "Guido van Rossum", manager: false, email: "guido.vanRossum@gmail.com", password: "password", dealership_id: 2, permission: 0)
Employee.create(name: "Paul Allen", manager: false, email: "paul.allen@gmail.com", password: "password", dealership_id: 1, permission: 0)
Employee.create(name: "Brian Kernighan", manager: false, email: "brian.kernighan@gmail.com", password: "password", dealership_id: 4, permission: 0)
Employee.create(name: "Andres Hejsberg", manager: false, email: "andres.hejsberg@gmail.com", password: "password", dealership_id: 5, permission: 0)
Employee.create(name: "Bram Cohen", manager: false, email: "bram.cohen@gmail.com", password: "password", dealership_id: 6, permission: 0)
Employee.create(name: "Jack Dorsey", manager: false, email: "jack.dorsey@gmail.com", password: "password", dealership_id: 1, permission: 0)
Employee.create(name: "Yukihiro Matsumoto", manager: false, email: "yukihiro.matsumoto@gmail.com", password: "password", dealership_id: 2, permission: 0)

