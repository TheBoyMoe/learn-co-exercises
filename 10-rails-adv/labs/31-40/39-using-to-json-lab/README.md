# Using To Json Lab

## Objectives

  1. Explain how to use `to_json` to display data.
  2. Use `respond_to` to render JSON or HTML from the same action.

## Introduction

We're going to convert the previous lab, where we created our own
`ProductSerializer`, to use `to_json` instead. The solution for the
previous lab has been included.

## Outline

1. Replace using `ProductSerializer` with using `to_json` to serialize
   the `Product`. Only include the product `id`, `name`, `description`,
`inventory` and `price` in the JSON response.
2. Remove the old `products/:id/data` route and action and set
   `products#show` to render JSON or HTML depending on the format of the
request.
3. Modify the `show.html.erb` page code to properly request JSON from
   the `products/id` route.
4. Make sure tests pass! Some will pass at the beginning. The trick is
   making sure they all *still* pass at the end!

**Note:** If you do everything correctly, you won't have to change any
of the code that constructs the `show` view, only the the route to
request the data.
