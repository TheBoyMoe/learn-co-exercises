# Your Own Js And Css In Rails

## Objectives

1. Write your own CSS and integrate it into the asset pipeline and use it in views.
2. Write your own JS and integrate it into the asset pipeline and use it in views.

## Objectives
Located in this repository is a simple Rails application. Your goal is to create your own JS and CSS and include it into the application. You can run the Capybara spec when you are finished to test your solution.

First add the following JS:

- In `/app/assets/javascripts/` create the file `hide.js`
- Create the function `hideWhenClicked` that hides the element that was clicked.
  - Make sure to bind to `#hide_this`
- Add `hide.js` to your JS manifest.

Next add the following CSS:

- In `/app/assets/stylesheets/` create the file `links.css`
- Create a CSS class called `.error` that changes the color of the text to red. Add this CSS class to the link on the root page.
- Create another CSS class called `.cool-background` that makes the background `grey`. Add this CSS class to the `<body>` tag on the application layout.
- Add `links.css` to your CSS manifest.

## PhantomJS Errors

If you receive an error stating that `phantomjs` can't be found on your system, install it with:

`brew install phantomjs`

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/your-own-js-and-css-in-rails' title='Your Own Js And Css In Rails'>Your Own Js And Css In Rails</a> on Learn.co and start learning to code for free.</p>
