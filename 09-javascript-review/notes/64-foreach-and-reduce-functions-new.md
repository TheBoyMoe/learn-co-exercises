# First-Class Functions Practice

## Objectives
1. Pass callback functions to `.forEach()` and `.sort()`.
2. Construct functions that return other functions as a way to cut down on code repetition.
3. Understand that a function returned by another function has access to any variables from the outer function.

## Introducing `.forEach()`
Prior to the introduction of the `for...of` statement, `.forEach()` was the single best way to iterate over all the elements in an array and perform the same action on each. `.forEach()` is a built-in method available on all JavaScript arrays that accepts one argument: a callback function. The callback function is invoked once for each element in the array, and three arguments are passed to it upon each invocation: the current element, the index of that element within the array, and the array itself. Here's an example:
```js
const callback = function (el, i, arr) {
  console.log('The current element is', el);
  console.log('The index of the current element is', i);
  console.log('The current array is', arr);
  console.log('----------------');
};

['Red', 'Yellow', 'Blue'].forEach(callback);
// LOG: The current element is Red
// LOG: The index of the current element is 0
// LOG: The current array is (3) ["Red", "Yellow", "Blue"]
// LOG: ----------------
// LOG: The current element is Yellow
// LOG: The index of the current element is 1
// LOG: The current array is (3) ["Red", "Yellow", "Blue"]
// LOG: ----------------
// LOG: The current element is Blue
// LOG: The index of the current element is 2
// LOG: The current array is (3) ["Red", "Yellow", "Blue"]
// LOG: ----------------
```

We can rebuild this same functionality with a `for...of` statement:
```js
const callback = function (el, i, arr) {
  console.log('The current element is', el);
  console.log('The index of the current element is', i);
  console.log('The current array is', arr);
  console.log('----------------');
};

const myForEach = function (arr, cb) {
  for (const el of arr) {
    cb(el, arr.indexOf(el), arr);
  }
};

myForEach(['Red', 'Yellow', 'Blue'], callback);
// LOG: The current element is Red
// LOG: The index of the current element is 0
// LOG: The current array is (3) ["Red", "Yellow", "Blue"]
// LOG: ----------------
// LOG: The current element is Yellow
// LOG: The index of the current element is 1
// LOG: The current array is (3) ["Red", "Yellow", "Blue"]
// LOG: ----------------
// LOG: The current element is Blue
// LOG: The index of the current element is 2
// LOG: The current array is (3) ["Red", "Yellow", "Blue"]
// LOG: ----------------
```

However, the benefit of `.forEach()` is that it's already available on **every** array in JavaScript — we don't need to build out anything additional. `.forEach()` provides a wonderfully compact, readable syntax for invoking a function on every member of an array. It's a powerful tool that makes it easier for us to perform complex operations in just a few lines of code.

## More practice with callbacks
`.forEach()` is one of the most common constructs for learning about callbacks in JavaScript because it's relatively easy to understand. We have a collection of elements and want to execute a function once for every element, so we pass a callback function to `.forEach()` and let it handle the implementation. That's the gist of callbacks: we create a function but delegate control of **when** it should be invoked to another function. The callback function doesn't care when it is invoked; it just knows that, at some later point, it **may** be invoked, perhaps after some other processes have completed or some data that it relies upon becomes available. Callbacks are one of the most important concepts that you'll employ throughout your JavaScript career. For some extra practice, let's take a look at the `.sort()` method available on all JavaScript arrays.

### `.sort()` it out!
<picture>
  <source srcset="https://curriculum-content.s3.amazonaws.com/web-development/js/advanced-functions/first-class-functions-practice-readme/bubble_sort.webp" type="image/webp">
  <source srcset="https://curriculum-content.s3.amazonaws.com/web-development/js/advanced-functions/first-class-functions-practice-readme/bubble_sort.gif" type="image/gif">
  <img src="https://curriculum-content.s3.amazonaws.com/web-development/js/advanced-functions/first-class-functions-practice-readme/bubble_sort.gif" alt="Bubble sort!">
</picture>

The `.sort()` method is a handy little helper for sorting an array _in-place_. That means that we're destructively rearranging the elements in the original array; we aren't sorting the elements and storing them in a new array. The method works by coercing each element into a string and comparing the Unicode value of each character. The letter `'A'` has a lower Unicode value than `'B'`, so, if a simple alphabetic ordering is what you're after, you're in good shape:
```js
const guestList = ['Kate', 'Jonas', 'Lisa', 'Jan', 'Kaitlin'];

guestList.sort();
// => ["Jan", "Jonas", "Kaitlin", "Kate", "Lisa"]

guestList;
// => ["Jan", "Jonas", "Kaitlin", "Kate", "Lisa"]
```

However, things get a little thorny if the strings aren't uniformly capitalized:
```js
const guestList = ["jan", "Jonas", "kaitlin", "Kate", "Lisa"];

guestList.sort();
// => ["Jonas", "Kate", "Lisa", "jan", "kaitlin"]
```

The Unicode values for uppercase letters are all lower than those for lowercase letters, so `.sort()` orders all of the title-case strings first and then all of the lowercase strings after. This is the method's default sorting behavior, and it's a bit annoying. However, lucky for us, we can customize it according to our needs by passing in a callback function.

#### `.sort()` with a callback
The callback function will be invoked once per comparison, and it needs to accept two arguments — the two elements that it's being asked to compare:
```js
guestList.sort(function (a, b) {
  // Comparison code in here.
});
```

The comparison function must return one of three values:
- If `a` should come **before** `b` in the new ordering, return a negative number.
- If `a` and `b` are equal, return `0`.
- If `a` should come **after** `b` in the new ordering, return a positive number.

Since we're comparing strings, this sounds like a job for `.localeCompare()`! From the [MDN documentation][localeCompare]:
>The `localeCompare()` method returns a number indicating whether a reference string comes before or after or is the same as the given string in sort order.
>...
>**Syntax**
>referenceStr.localeCompare(compareString)
>...
>**Return value**
>A negative number if the reference string occurs before the compare string; positive if the reference string occurs after the compare string; 0 if they are equivalent.

That's exactly what we need! Now let's fill out our callback to correctly sort strings in a case-insensitive manner:
```js
guestList.sort(function (a, b) {
  return a.localeCompare(b);
});
// => ["jan", "Jonas", "kaitlin", "Kate", "Lisa"]
```

Woohoo! We can even make that a bit cleaner by splitting the callback out into its own variable:
```js
const comparator = function (a, b) {
  return a.localeCompare(b);
};

guestList.sort(comparator);
// => ["jan", "Jonas", "kaitlin", "Kate", "Lisa"]
```

Nice. But what if we're sorting an array of numbers instead of strings? The default comparison algorithm won't work:
```js
const primes = [13, 7, 17, 2, 5, 3];

primes.sort();
// => [13, 17, 2, 3, 5, 7]
```

The `.sort()` method coerces the numbers into strings and then compares each character. The first character of `'17'` is `'1'`, which has a lower Unicode value than the first (and only) character of `'2'`. Instead of relying on the default algorithm, let's pass in a callback that correctly sorts our numbers in ascending order:
```js
const numberSorter = function (num1, num2) {
  return num1 - num2;
};

primes.sort(numberSorter);
// => [2, 3, 5, 7, 13, 17]
```

If `num1` is larger than `num2`, the subtraction operation will return a positive number, which tells `.sort()` to reverse the order of `num1` and `num2` in the array. If `num1 - num2` returns a negative number or `0`, `.sort()` knows to not mess with the ordering.

### Reduce! Reduce!
In the world of programming, we often work with arrays of similar elements. Sometimes, we need to aggregate a result from those elements — perhaps summing an array of numbers or concatenating an array of strings into one long string. In other words, we want to _reduce_ the array to a single, ultimate value. For example, imagine that we have a series of products in a shopping cart, and we'd like to know the total price of all items in the cart:
```js
const products = [
  { name: 'Head & Shoulders Shampoo', price: 4.99 },
  { name: 'Twinkies', price: 7.99 },
  { name: 'Oreos', price: 6.49 },
  { name: 'Jasmine-scented bath pearls', price: 13.99 }
];
```

We can create a function that accepts the array of products, initializes a starting value (`totalPrice`), and then iterates over the passed-in `products` array, adding each product's price to the sum stored in `totalPrice`:
```js
const getTotalAmountForProducts = function (products) {
  let totalPrice = 0;

  products.forEach(function (product) {
    totalPrice += product.price;
  });

  return totalPrice;
};

getTotalAmountForProducts(products);
// => 33.46
```

That's all well and good, but then what if we actually want to reduce the `products` array of objects to a simple array that just contains the product `name`s as strings? We definitely can't use our `getTotalAmountForProducts()` function — we'll have to create a new one:
```js
const gatherProductNames = function (products) {
  const names = [];

  products.forEach(function (product) {
    names.push(product.name);
  });

  return names;
};

gatherProductNames(products);
// => ["Head & Shoulders Shampoo", "Twinkies", "Oreos", "Jasmine-scented bath pearls"]
```

It's kind of annoying to have to create an entirely new function every time we want to change what we're aggregating inside the `.forEach()` iteration. Instead of hard-coding it, wouldn't it be nice to extract that logic out into a callback function? Well, thanks to JavaScript's built-in `.reduce()` method for arrays, we can! Here's the [MDN documentation][reduce] on `.reduce()`:
>The reduce() method applies a function against an accumulator and each element in the array (from left to right) to reduce it to a single value.
>...
>**Syntax**
>arr.reduce(callback[, initialValue])
>...
>**Return value**
>The value that results from the reduction.

The method takes two arguments, a callback function that will reduce each array element into a single, ultimate value and the initial value that the reduction should start from. For example, if we needed to sum an array of numbers but, instead of starting from `0`, we wanted to start counting from `1000`, we could pass `1000` in as the initial value.

The callback function accepts four arguments:
1. The reduced total as it currently stands (or the initial value if nothing's been reduced yet).
2. The current element that's to be reduced.
3. The index of the current element within the array.
4. The entire array.

Let's take `.reduce()` for a spin:
```js
const reduceProductNames = function (agg, el, i, arr) {
  console.log('The aggregate up to this point is:', agg);
  console.log("The current element's name is:", el.name);
  console.log('The index of the current element is:', i);
  console.log('----------------');

  return [...agg, el.name];
};

products.reduce(reduceProductNames, []);
// LOG: The aggregate up to this point is: []
// LOG: The current element's name is: Head & Shoulders Shampoo
// LOG: The index of the current element is: 0
// LOG: ----------------
// LOG: The aggregate up to this point is: ["Head & Shoulders Shampoo"]
// LOG: The current element's name is: Twinkies
// LOG: The index of the current element is: 1
// LOG: ----------------
// LOG: The aggregate up to this point is: (2) ["Head & Shoulders Shampoo", "Twinkies"]
// LOG: The current element's name is: Oreos
// LOG: The index of the current element is: 2
// LOG: ----------------
// LOG: The aggregate up to this point is: (3) ["Head & Shoulders Shampoo", "Twinkies", "Oreos"]
// LOG: The current element's name is: Jasmine-scented bath pearls
// LOG: The index of the current element is: 3
// LOG: ----------------
// => ["Head & Shoulders Shampoo", "Twinkies", "Oreos", "Jasmine-scented bath pearls"]

const reduceProductPrices = function (agg, el, i, arr) {
  console.log('The aggregate up to this point is:', agg);
  console.log('The index of the current element is:', i);
  console.log("The current element's price is:", el.price);
  console.log('----------------');

  return agg + el.price;
};

products.reduce(reduceProductPrices, 0);
// LOG: The aggregate up to this point is: 0
// LOG: The index of the current element is: 0
// LOG: The current element's price is: 4.99
// LOG: ----------------
// LOG: The aggregate up to this point is: 4.99
// LOG: The index of the current element is: 1
// LOG: The current element's price is: 7.99
// LOG: ----------------
// LOG: The aggregate up to this point is: 12.98
// LOG: The index of the current element is: 2
// LOG: The current element's price is: 6.49
// LOG: ----------------
// LOG: The aggregate up to this point is: 19.47
// LOG: The index of the current element is: 3
// LOG: The current element's price is: 13.99
// LOG: ----------------
// => 33.46
```

If we take out our verbose logging that's just helping us visualize what's happening inside `.reduce()`, the method is a delightfully extensible way to reduce an array to a single value:
```js
const stringify = function (agg, el, i, arr) {
  let stringifiedElement = el.name + ' is $' + el.price + '. ';

  if (i === arr.length - 1) {
    stringifiedElement += 'The total price is $' + (agg.totalPrice + el.price) + '.';

    return agg.string + stringifiedElement;
  }

  return {
    string: agg.string + stringifiedElement,
    totalPrice: agg.totalPrice + el.price
  };
};

products.reduce(stringify, { string: '', totalPrice: 0 });
// => "Head & Shoulders Shampoo is $4.99. Twinkies is $7.99. Oreos is $6.49. Jasmine-scented bath pearls is $13.99. The total price is $33.46."
```

We managed to reduce all the information in the `products` array of objects down to a single string!

## More practice with functions that return functions
As a final exercise, you've been onboarded to the Flatbook team tasked with internationalizing some of the tax calculators used by the finance team. When a Flatbook employee goes abroad on a business trip, they track expenses and submit receipts upon their return. The engineering team created a simple tool to help the finance team calculate tax and remember which items are tax-free in a certain country. However, it's currently not very [DRY][dry]:
```js
const franceTax = function (item, priceInCents) {
  const formattedPrice = '$' + (priceInCents / 100).toFixed(2);

  const exemptItems = ['wine', 'macaron', 'baguette', 'croissant'];
  const exempt = exemptItems.indexOf(item.toLowerCase()) > -1;

  const taxRate = 0.15;
  const taxDue = exempt ? 0 : priceInCents * taxRate / 100;
  const formattedTaxDue = '$' + taxDue.toFixed(2);

  console.log(`In France, ${item} costs ${formattedPrice}.`);
  console.log('That item', exempt ? 'is' : 'is not', 'exempt from taxation.');
  console.log(`The total tax due is: ${formattedTaxDue}.`);
};

const canadaTax = function (item, priceInCents) {
  const formattedPrice = '$' + (priceInCents / 100).toFixed(2);

  const exemptItems = ['maple syrup', 'poutine', 'kindness'];
  const exempt = exemptItems.indexOf(item.toLowerCase()) > -1;

  const taxRate = 0.125;
  const taxDue = exempt ? 0 : priceInCents * taxRate / 100;
  const formattedTaxDue = '$' + taxDue.toFixed(2);

  console.log(`In Canada, ${item} costs ${formattedPrice}.`);
  console.log('That item', exempt ? 'is' : 'is not', 'exempt from taxation.');
  console.log(`The total tax due is: ${formattedTaxDue}.`);
};

const mexicoTax = function (item, priceInCents) {
  const formattedPrice = '$' + (priceInCents / 100).toFixed(2);

  const exemptItems = ['queso', 'futbol', 'tequila', 'avocado'];
  const exempt = exemptItems.indexOf(item.toLowerCase()) > -1;

  const taxRate = 0.05;
  const taxDue = exempt ? 0 : priceInCents * taxRate / 100;
  const formattedTaxDue = '$' + taxDue.toFixed(2);

  console.log(`In Mexico, ${item} costs ${formattedPrice}.`);
  console.log('That item', exempt ? 'is' : 'is not', 'exempt from taxation.');
  console.log(`The total tax due is: ${formattedTaxDue}.`);
};

franceTax('Big Mac', 249);
// LOG: In France, Big Mac costs $2.49.
// LOG: That item is not exempt from taxation.
// LOG: The total tax due is: $0.37.

franceTax('wine', 499);
// LOG: In France, wine costs $4.99.
// LOG: That item is exempt from taxation.
// LOG: The total tax due is: $0.00.

canadaTax('kindness', 0);
// LOG: In Canada, kindness costs $0.00.
// LOG: That item is exempt from taxation.
// LOG: The total tax due is: $0.00.

mexicoTax('tacos al pastor', 350);
// LOG: In Mexico, tacos al pastor costs $3.50.
// LOG: That item is not exempt from taxation.
// LOG: The total tax due is: $0.17.
```

It's really the same function repeated three times, with three small dynamic pieces:
- The name of the country.
- The tax rate.
- The list of exempt items.

### Closures
We can easily decouple those three customizations from the rest of the logic that remains consistent across all three functions. In fact, we can create a function that assembles new tax calculating functions for us! Let's take a look:
```js
const newTaxFunction = function (countryName, taxRate, ...exemptItems) {
  return function (item, priceInCents) {
    const formattedPrice = '$' + (priceInCents / 100).toFixed(2);
    const exempt = exemptItems.indexOf(item) > -1;
    const taxDue = exempt ? 0 : priceInCents * taxRate / 100;
    const formattedTaxDue = '$' + taxDue.toFixed(2);

    console.log(`In ${countryName}, ${item} costs ${formattedPrice}.`);
    console.log('That item', exempt ? 'is' : 'is not', 'exempt from taxation.');
    console.log(`The total tax due is: ${formattedTaxDue}.`);
  };
};
```

Our `newTaxFunction()` function can accept two or more arguments. After the first two arguments, every subsequent argument will be captured in the `...exemptItems` _spread parameter_, which leverages the spread operator introduced in ES2015. Our function returns a function, but the returned function still has access to all variables declared in its outer environment, including `countryName`, `taxRate`, and `exemptItems`. Because it retains access to these variables even after `newTaxFunction()` has finished executing, we say that the returned function has _closed over_ those variables — it has formed a _closure_.



We can invoke `newTaxFunction()` three times, passing in a different set of arguments each time. Each invocation will create an entirely separate closure that retains access to the set of arguments passed in for that particular invocation. Let's see it in action:
```js
const franceTax = newTaxFunction('France', 0.15, 'wine', 'macaron', 'baguette', 'croissant');

const canadaTax = newTaxFunction('Canada', 0.125, 'maple syrup', 'poutine', 'kindness');

const mexicoTax = newTaxFunction('Mexico', 0.05, 'queso', 'futbol', 'tequila', 'avocado');

canadaTax('poutine', 599);
// LOG: In Canada, poutine costs $5.99.
// LOG: That item is exempt from taxation.
// LOG: The total tax due is: $0.00.

canadaTax('futbol', 1999);
// LOG: In Canada, futbol costs $19.99.
// LOG: That item is not exempt from taxation.
// LOG: The total tax due is: $2.50.

mexicoTax('Big Mac', 199);
// LOG: In Mexico, Big Mac costs $1.99.
// LOG: That item is not exempt from taxation.
// LOG: The total tax due is: $0.10.

franceTax('macaron', 149);
// LOG: In France, macaron costs $1.49.
// LOG: That item is exempt from taxation.
// LOG: The total tax due is: $0.00.
```

We invoke `newTaxFunction()`, pass in our arguments, and store the returned function in a variable, e.g., `canadaTax`. The `canadaTax` variable thereafter contains a reference to a function that accepts two arguments, an `item` and a `priceInCents`. Take a look:
```js
canadaTax;
// => ƒ (item, priceInCents) {
//        const formattedPrice = '$' + (priceInCents / 100).toFixed(2);
//        const exempt = exemptItems.indexOf(item) > -1;
//        const taxDue = exempt ? 0 : priceInCents * taxRate / 10…
```

Nowhere in that function is `countryName`, `taxRate`, or `exemptItems` defined, but we still have access to the values that were passed to `newTaxFunction()` when it was invoked. Aren't closures amazing?!


## Resources
- Array
  + [`.forEach()`][forEach]
  + [`.sort()`][sort]
  + [`.reduce()`][reduce]
- String
  + [`.localeCompare()`][localeCompare]
- [StackOverflow — How do JavaScript closures work?][stack overflow]

[forEach]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach
[sort]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/sort
[localeCompare]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/localeCompare
[reduce]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/reduce
[dry]: https://en.wikipedia.org/wiki/Don't_repeat_yourself
[stack overflow]: https://stackoverflow.com/questions/111102/how-do-javascript-closures-work

