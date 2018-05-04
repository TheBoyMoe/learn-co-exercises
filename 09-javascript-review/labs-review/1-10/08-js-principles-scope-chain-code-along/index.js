var customerName = 'bob';
const leastFavoriteCustomer = 'pete';

function upperCaseCustomerName(){
  customerName = customerName.toUpperCase();
}

function setBestCustomer(){
  bestCustomer = 'not bob';
}

function overWriteBestCustomer(string){
  bestCustomer = string;
}

function changeLeastFavoriteCustomer(){
  leastFavoriteCustomer = 'john';
}

function attemptTwoFavoriteCustomers(){
  let favoriteCustomer = 'pete';
  let favoriteCustomer = 'john';
}

