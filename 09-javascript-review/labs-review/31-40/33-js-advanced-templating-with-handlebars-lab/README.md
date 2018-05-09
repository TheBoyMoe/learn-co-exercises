# JavaScript Handlebars Templates Lab

## Objectives

1. Practice using Handlebars templates
2. Practice defining Handlebars helpers
3. Practice using Handlebars partials

## Introduction

In this lab we're going to build a simple recipe application using Handlebars templates. Follow the instructions below, and don't forget to run test and try out your app to make sure everything works!

You'll be using templates, creating custom helpers, and using partials. Help can be found at the [Handlebars](http://handlebarsjs.com) website, and we'll briefly review the basics below.

## Handlebars Templates and Helpers

We can construct templates within script tags using the `{{}}` delimiters to mark data values, like this:

```html
<script id="my-template" type="text/x-handlebars-template">
  <div id="recipe">
    <p>{{description}}</p>
    <ul>
      {{#each ingredients}}
      <li>{{name}}</li>
      {{/each}}
    </ul>
  </div>
</script>
```

Keep in mind that the placeholder values within the double curly braces must match the names of attributes on the object that you pass as context to the template.

We can also use the `each` helper on a collection, in this case the `ingredients` property of the current recipe, to render a part of a template multiple times.

To render this template, our JavaScript code would look like this:

```js
var recipe = {
  description: 'yummy chicken noodle soup',
  ingredients: [
    {quantity: "1 cup", name: 'chicken'},
    {quantity: "3 nanoliters", name: 'stock'},
    {quantity: "12", name: 'noodles'}
  ]
}

var template = Handlebars.compile(document.getElementById("my-template").innerHTML);
var html = template(recipe);
```

First we use `Handlebars.compile` to create the `template` function from the `innerHTML` of our template, then we execute the `template` function with a context object, `recipe`, to get rendered HTML.

## Handlebars Partials

Handlebars also has the concept of a _partial_, or a bit of template that you can use to compose larger templates. Partials are useful when you have a chunk of markup that you want to reuse in more than one place.

A [Handlebars partial](http://handlebarsjs.com/partials.html) is just a template that you can render inside of another template using the `{{> partialName }}` partial call syntax after registering it with `Handlebars.registerPartial`.

Let's look at a quick example.

```html
<script id="main-template" type="text/x-handlebars-template">
  {{> namePartial }}
</script>
<script id="partial-template" type="text/x-handlebars-template">
  <div>{{ name }}</div>
</script>
```

```js
Handlebars.registerPartial('namePartial', document.getElementById("partial-template").innerHTML)
function renderMain() {
  var template = Handlebars.compile(document.getElementById("main-template").innerHTML);
  var html = template({name: 'Gordon Ramsay'});
}
```

By default, the partial will receive the same context object as the template that calls it, so our partial has the same access to `name` as the main template does.

## Instructions

1. Create a form template with an `id` of `recipe-form-template` that will be used to enter new recipes. Make the form submit with a `createRecipe()` function. Provide inputs for recipe `name`, `description`, and at least five `ingredients`. **Hint:** Get comfy collecting values with `getElementsByName()`.
2. Create a template with an `id` of `recipe-template`. This template should contain the recipe `name` and an "Edit Recipe" link, and render the `recipeDetailsPartial` in step 3. Render this template with the recipe data when the user submits the form.
3. Register a partial called `recipeDetailsPartial` for the `description` and `ingredients` of the recipe. Create a template with an `id` of `recipe-details-partial` to hold the markup. Use the `each` helper to display the collection of `ingredients`.
4. Use a custom helper called `displayIngredient` to display each ingredient within the `each` block.
5. On click of your "Edit Recipe" link, call a `displayEditForm()` function that renders a template called `recipe-form-template`. Allow your recipe to be edited using this form, and re-render the recipe template with the updated information using a `updateRecipe()` function on form submit.
6. Refactor your forms so that `recipe-form` and the edit form template are both constructed with the same `recipe-form-template`. The template should render with the recipe data for edit, and with empty values for a new recipe. **Hint:** Don't forget you can pass any object with any properties as the context for your templates, including, for instance, values for `onsubmit`.

**Note:** The provided `index.js` includes a function called `init` that will be called when the page loads. Put any Handlebars registration code and page initialization code you need inside this function or your tests will not function correctly.

# Resources

- [Handlebars](http://handlebarsjs.com)
- [Handlebars partials](http://handlebarsjs.com/partials.html)
