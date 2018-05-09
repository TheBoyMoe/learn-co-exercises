const store = { drivers: [], passengers: [], trips: [] };
let driverId = 0;
let passengerId = 0;
let tripId = 0;

class Driver {
  constructor(name){
    this.name = name;
    this.id = ++driverId;
    store.drivers.push(this);
  }

  // return all trips driver has taken
  trips(){
    return store.trips.filter(trip => trip.driverId === this.id);
  }

  // return all the passengers that the driver has driven
  passengers(){
    let trips = this.trips();
    return trips.map(trip => trip.passenger());
  }
}

class Passenger {
  constructor(name){
    this.name = name;
    this.id = ++passengerId;
    store.passengers.push(this);
  }

  // all the trips the passenger has taken
  trips(){
    return store.trips.filter(trip => trip.passengerId === this.id);
  }

  // all the drivers who have taken the passenger
  drivers(){
    let trips = this.trips();
    return trips.map(trip => trip.driver());
  }
}

class Trip {
  constructor(driver, passenger){
    this.driverId = driver.id;
    this.passengerId = passenger.id;
    this.id = ++tripId;
    store.trips.push(this);
  }

  // driver associated with the trip
  driver(){
    return store.drivers.find(driver => driver.id === this.driverId);
  }

  // passenger associated with the trip
  passenger(){
    return store.passengers.find(passenger => passenger.id === this.passengerId);
  }

}
