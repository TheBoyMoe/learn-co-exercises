# Class Relations Lab

## Objectives
+ Use class syntax to construct objects
+ Use JavaScript iterator methods to build class relations

## Instructions

In the following lab, we want to model our Scuber system in such a way that we can see all of the passengers related to a driver.  A driver becomes related to a passenger when he takes a single trip.  Only one passenger is associated with a trip -- the passenger who books, and pays for the trip on their phone.

Each class should be defined in such a way that it adds an incrementing id to each individual instance of the respective class.  An object should also be added to the store upon being initialized.

Construct the following classes:

`Driver` class:
  + A driver has many trips, and has many passengers through trips.
  + `new Driver()` - initialized with a name; returns a JavaScript object that has attributes of `id`, and `name`
  + `trips()` - returns all of the trips that a driver has taken
  + `passengers()` - returns all of the passengers that a driver has taken on a trip

`Passenger` class:
  + A passenger has many trips, and has many drivers through trips.
  + `new Passenger()` - initialized with a name; returns a JavaScript object that has attributes of `id`, and `name`
  + `trips()` - returns all of the trips that a passenger has taken
  + `drivers()` - returns all of the drivers that has taken a passenger on a trip

`Trip` class:
  + A trip belongs to a driver and belongs to a passenger.
  + `new Trip()` - initialized with an instance of driver and an instance of passenger; returns a JavaScript that has attributes `id`, `driverId`, and `passengerId`
  + `driver()` - returns the driver associated with the trip
  + `passenger()` - returns the passenger associated with the trip
