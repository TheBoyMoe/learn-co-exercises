# DIY JSON Serializer Lab

## Objectives

  1. Write a JSON Serializer
  2. Use that JSON Serializer to render information without page reload

## Introduction

We're going to use our product/order system and enhance it so that
customers can browse the product catalog without refreshing the page.

You'll be modifying and building on the code from the previous lab,
which is provided.

## Instructions

1. Create a `ProductSerializer` that serializes all of a product's
   attributes (`name`, `price`, `inventory` and `description`) to JSON.
2. Create a route and action for `/products/:id/data` that returns a
   JSON-serialized `product`.
3. Create the product `show` page and route. Add a link to the products `show` page called "Next Product" that
   will use AJAX to load the data for the next product without refreshing the page.
4. Make sure tests pass, including already existing ones!

**Note:** The test suite makes use of `selenium-webdriver` to test the
AJAX-enabled pages. You will need to have Firefox installed for the
tests to pass.
