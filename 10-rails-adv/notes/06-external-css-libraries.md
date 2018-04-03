# External CSS Libraries in Rails

## Outline
Loading stylesheets into our application can be done a few different ways in Rails. We can use HTML link tags for CSS located on another server. We can place third party CSS files in our vendor folder.  We can also use gems to load the CSS frameworks we need like Twitter Bootstrap.

## External Stylesheets
So far we have been loading CSS from our asset directories. You aren't required to do it this way, but it does allow us to easily manage our CSS. The other way to load CSS is by using standard HTML `<style>` tags placed in the `<head>` tag of our application layout. There are benefits to using this approach. We can load stylesheets from other peoples CDNs without having to set one up ourselves. This can save us bandwidth and help with download speeds for users throughout the world. To load CSS like this, we create HTML link tags in the `<head>` of our application layout file.

```html
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
</head>
```

## Vendor Assets
Managing a lot of different third party CSS files can be hard. We may lose track which files are for which CSS frameworks. Also, separate link tags mean these files will need to be downloaded one by one on the browser, and this will slow page load times. At some point, we will probably decide to have these external CSS files be internal CSS files.

We don't really want to clutter our main `assets/stylesheets` folder with CSS files maintained by others. Rails provides the `vendor/assets/stylesheets` folder for these types of CSS files. We can place our third party CSS frameworks in here and add them to our CSS manifest file. We get the added benefit of having all external CSS files combined into one file with all our application CSS files.

## Gems
Manually adding CSS to our vendor directory can also be cumbersome and hard to maintain. New versions of CSS frameworks are released, and it's easy to fall behind. Luckily for us, many of the popular CSS frameworks have gems. These gems package up these CSS frameworks and, when installed, add them to our asset path, allowing us to require them inside of our CSS manifest file.

To install the Twitter Bootstrap gem in our Gemfile, you will need to add `gem "bootstrap-sass"` to your Gemfile and run `bundle install`. Once that completes, you are able to add `*= require bootstrap` to the CSS manifest file. Now, Bootstrap will be loaded by Rails. We can also use bundler to update Twitter Bootstrap when new versions are released. Handling updating is particularly helpful for bigger CSS frameworks like Bootstrap that have many CSS files.

## References
- [Bootstrap SASS Gem](https://github.com/twbs/bootstrap-sass)

