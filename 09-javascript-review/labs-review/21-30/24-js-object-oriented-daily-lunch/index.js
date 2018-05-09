const store = { deliveries: [], customers: [], employers: [], meals: [] };
let customerId = 0;
let employerId = 0;
let mealId = 0;
let deliveryId = 0;

class Customer {
  constructor(name, employer = {}){
    this.name = name;
    this.employerId = employer.id;
    this.id = ++customerId;
    store.customers.push(this);
  }

  // meals delivered to the customer
  meals(){
    return this.deliveries().map(delivery => delivery.meal());
  }

  // deliveries received by the customer
  deliveries(){
    return store.deliveries.filter(delivery => delivery.customerId === this.id);
  }

  // amount customer has spent on meals delivered
  totalSpent(){
    return this.meals().reduce((total, meal) => { return total += meal.price }, 0);
  }
}

class Delivery {
  constructor(meal = {}, customer = {}){
    this.mealId = meal.id;
    this.customerId = customer.id;
    this.id = ++deliveryId;
    store.deliveries.push(this);
  }

  // meal associated with the delivery
  meal(){
    return store.meals.find(meal => meal.id === this.mealId);
  }

  // customer associated with the delivery
  customer(){
    return store.customers.find(customer => customer.id === this.customerId);
  }
}

class Employer {
  constructor(name){
    this.name = name;
    this.id = ++employerId;
    store.employers.push(this);
  }

  // list of employees who are customers
  employees(){
    return store.customers.filter(customer =>  customer.employerId === this.id );
  }

  // list of deliveries ordered by employees
  deliveries(){
    return this.employees().reduce((list, customer) => {
       return list.concat(...customer.deliveries());
    }, []);
  }

  // list of meals ordered by employees
  meals(){
    let meals = this.employees().reduce((list, customer) => {
      return list.concat(...customer.meals());
    }, []);

    return meals.filter((meal, index, meals)=>{
      return meals.indexOf(meal) === index;
    });
  }

  // return the number of times each meal was ordered
  // { pastaMealid: 1, chickenMealid: 2 }
  mealTotals(){
    let meals = this.employees().reduce((list, customer) => {
      return list.concat(...customer.meals());
    }, []);

    return meals.reduce((acc, meal)=>{
      acc[meal.id] = (acc[meal.id])? ++acc[meal.id] : 1;
      return acc;
    }, {});

  }
}

class Meal {
  constructor(title, price){
    this.title = title;
    this.price = price;
    this.id = ++mealId;
    store.meals.push(this);
  }

  // all deliveries of that particular meal
  deliveries(){
    return store.deliveries.filter(delivery => delivery.mealId === this.id);
  }

  // all customers who have had that particular meal
  customers(){
    return this.deliveries().map(delivery => delivery.customer());
  }

  // static method that sorts meals by price
  static byPrice(){
    return store.meals.sort((a, b)=>{
      return a.price < b.price;
    });
  }
}

