# Bootstrap Asset Pipeline

## Objectives

1. Identify the components included in bootstrap (namely the CSS and JS required to integrate bootstrap - two main files compressed and minified composed of individual parts).
2. Integrate Bootstrap manually with CDN (not preferred way).
3. Use the bootstrap gem and add the correct requires to your manifest.
4. Rely on bootstrap provided CSS and javascript to power the frontend.

## Outline
Starting a web application can be overwhelming. There are so many decisions to make that it can be hard to manage. The last thing we want is to make a great application that looks terrible and doesn't respond to well to different screen sizes. It would be great if we could just add something to our application that made structuring our UI as easy as Rails makes everything else. [Twitter Bootstrap](http://getbootstrap.com/) does just that. It's a grid-based CSS framework that provides the ability to create great looking, responsive websites.

[Twitter Bootstrap](http://getbootstrap.com/) has some really good documentation as well. If you browse to their site and click on [CSS](http://getbootstrap.com/css/) in the menu, you will see how to structure your HTML and CSS in a way that allows for an easy, responsive UI.

If you click on [Components](http://getbootstrap.com/components/), you will see how to use all the reusable components that Bootstrap provides. These are common parts of websites like buttons, dropdowns and navigation.

Finally, if you click on [JavaScript](http://getbootstrap.com/javascript/), you will see how to use Bootstrap's JavaScript component to enhance our application. It makes creating modals and collapsing menus super easy.

## Integration
When including Bootstrap in our application, we will most likely want to include the whole framework. This can be done a few different ways.

This first option, which is not preferred because it doesn't take advantage of the asset pipeline, is to use a `<link>` tag in the `<head>`.

```html
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
```

and a `<script>` tag at the bottom of the `<body>` tag.

```html
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
</body>
```

Our preferred way is to use a gem. To do this, include the following in our Gemfile:

```ruby
gem 'bootstrap-sass'

```

Now run `bundle install`. Finally, include the following in your CSS manifest file:

```css
@import "bootstrap-sprockets";
@import "bootstrap";
```

And the following in your JavaScript manifest file.

```JavaScript
//= require bootstrap-sprockets
```

That's it! Now we have Boostrap ready to go, and any additional updates only require a `bundle update`.

## Using Bootstrap
Let's say you've created an amazing design for your web application. You tweaked the margins and padding just right, and the content aligned just the way you want. The whole time you've had your browser in full screen so you decide to shrink your browser window to see what happens only to discover that your awesome design doesn't look so awesome now. Next, you take out your phone and browse to your application. To your dismay, your website is even worse on your phone. It's hard to read and requires a ton of scrolling and zooming to see anything.

To solve our problem, we could create completely new designs for each screen size, but this can easily become hard to manage. Every time you add a new feature, it has to be added in multiple places and customized for that specific layout. This is the problem that [Responsive Web Design](https://en.wikipedia.org/wiki/Responsive_web_design) aims to fix. By using [media queries](https://developer.mozilla.org/en-US/docs/Web/CSS/Media_Queries/Using_media_queries) and careful design, we can create a website that changes depending on the screen size. Twitter Bootstrap helps us manage the complexities of responsive web design by providing a grid system to work with.

## Grid Layout
Bootstrap's grid system divides the screen into rows with 12 columns. These columns contain our content. We can choose how to lay out our site by creating 12 individual columns or fewer bigger columns. For example, here is a grid divided into 12 columns:

```html
<body>
  <div class="container">
    <div class="row">
      <div class="col-lg-1">
        <p>Column #1</p>
      </div>
      <div class="col-lg-1">
        <p>Column #2</p>
      </div>
      <div class="col-lg-1">
        <p>Column #3</p>
      </div>
      <!-- ... columns 4 through 11 ... -->
      <div class="col-lg-1">
        <p>Column #12</p>
      </div>
    </div>
  </div>
</body>
```

Each column would be very narrow and probably not able to fit much content. If we want, we could also just have two bigger columns:

```html
<body>
  <div class="container">
    <div class="row">
      <div class="col-lg-6">
        <p>Column #1</p>
      </div>
      <div class="col-lg-6">
        <p>Column #2</p>
      </div>
    </div>
  </div>
</body>
```
Notice how instead of 12 `<div>` tags with the CSS class `col-lg-1` we use 2 `<div>` tags with the CSS class `col-lg-6`. The combined total of these two columns is still 12. This is an important aspect of Bootstrap. We should always be able to add the columns together to get a total of 12.

From here, there are a lot of different ways we could configure our grid to respond to different screen sizes in different ways. Refer back to the documentation and examples to help.

## References
- [Twitter Bootstrap](http://getbootstrap.com/)
- [Responive Web Design](https://en.wikipedia.org/wiki/Responsive_web_design)
- [media queries](https://developer.mozilla.org/en-US/docs/Web/CSS/Media_Queries/Using_media_queries)

