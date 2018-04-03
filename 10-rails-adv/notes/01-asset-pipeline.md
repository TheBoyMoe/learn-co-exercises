# What Is The Asset Pipeline

## Objectives

1. Understand the 4 main features of the asset pipeline.
2. Identify the Asset Paths
3. Know how Asset Manifests provide concatenation of CSS and JS.
4. Use preprocessing languages like SASS or CoffeeScript
5. Define Asset Fingerprinting

## Outline

For a long time, we treated JavaScript and CSS as an afterthought in developing web applications. All of our asset code — things like images, stylesheets, and JavaScripts — was kept in a massive folder called `public` and served outside of the context of our Rails application. As the web evolved, that no longer made sense.

The asset pipeline is the Rails answer to managing stylesheets, JavaScripts, and images.

## Asset Paths

A lot of files go into creating web applications. The CSS and JavaScript files alone can be hard to organize. What folders do we create? Which files go where? The Asset Pipeline provides an answer for this problem. We have to keep things very organized in our application, but, by keeping separate files and folders for each concept or unit of code, we have 2 problems.

1. How does Rails know where things are? Is the calendar JS file in `app/assets/javascripts/calendar.js` or `vendor/javascripts/calendar.js`?
2. We don't want to serve each file separately as this will make our page load very slow. It makes sense for us to maintain separate small files for readability and organization, but, for the browser, we'd rather smash all those small files together and load 1 JS file and 1 CSS file. This process is called concatenation.

Let's talk about our first problem: how does Rails know where to look? The Asset Pipeline has a concept called Asset Paths for handling this. Just like in BASH where we have a PATH environment variable that is a combination of folder paths, the Asset Path is a combination of folder paths for Rails to look for assets in. Let's take a look at an example of how our Asset Path is configured.

```ruby
Rails.application.config.assets.paths =>
[
  "/Users/avi/asset-test/app/assets/images",
  "/Users/avi/asset-test/app/assets/javascripts",
  "/Users/avi/asset-test/app/assets/stylesheets",
  "/Users/avi/asset-test/vendor/assets/javascripts",
  "/Users/avi/asset-test/vendor/assets/stylesheets",
  "/Users/avi/.rvm/gems/ruby-2.2.3/gems/turbolinks-2.5.3/lib/assets/javascripts",
  "/Users/avi/.rvm/gems/ruby-2.2.3/gems/jquery-rails-4.1.0/vendor/assets/javascripts",
  "/Users/avi/.rvm/gems/ruby-2.2.3/gems/coffee-rails-4.1.1/lib/assets/javascripts"
]
```
If we put an asset in any of these folders, we can access them via the URL '/assets' in our application. If you have additional folders for Rails to search, you can add the folders to the Asset Path. This is done in the file `config/initializers/assets.rb`.

```ruby
Rails.application.config.assets.paths << "New Path"
```

We can put assets anywhere, configure our Asset Path, and access them via a single '/assets' URL.

## Manifests and Concatenation

Now that we can put files anywhere, how do we get them to be included in our web pages? The Asset Pipeline uses a manifest file to tell Rails what to load. This manifest file is a central location where we can list all the CSS and JS files our application needs. This isn't a feature of JS or CSS but rather the asset pipeline. Here is an example of what our JS manifest file looks like:

File: app/assets/javascripts/application.js
```
//= require jquery
//= require calendar
```
When you include the manifest file in your layout with the `javascript_include_tag`, the asset pipeline will look for all of the files listed in the Asset Path. To include the css manifest file in your app, `application.css`, use the `stylesheet_link_tag`. Notice how we require calendar. This file lives in `app/assets/javascripts/calendar.js`, yet we only specified the name and not the full path. The Asset Pipeline will search all the configured paths for a file with the name we provided.

Now that we solved the question of discoverability, let's talk about concatenation. Like we discussed earlier, we don't want to load our files in the browser one by one. It's better to perform one download than a bunch of small downloads from our browser. The manifest files we configure in Rails will automatically concatenate the files listed in them into one file in production. This might not be the best option when we are developing our application since it can make debugging hard. However, Rails will actually serve each file separately when we are running in development mode. No need to do anything.

Finally, the sprocket directives that power our asset manifests will be covered in detail later.

## Preprocessing

Being able to combine files and load them from a set of predefined locations in our application is a great benefit of the Asset Pipeline. That's only the beginning. Because we're loading assets through Rails, we can preprocess the files using popular languages like SCSS for writing better CSS and Coffeescript for cleaner JS. If you make an asset named theme.css.scss, you are telling the asset pipeline to run the file through the SCSS preprocessor before serving theme.css to the browser. The SCSS preprocessor compiles the file into CSS. The only thing we had to do was provide the correct file extension, `.scss`, to the file and the asset pipeline knows to run it through the SCSS preprocessor.

## Fingerprinting

The last benefit we will talk about is Fingerprinting, but first let's talk about the problem it helps us solve. When we serve files to the browser, they are likely to be cached to avoid downloading them again in the future. What's caching you might ask?

Caching something means keeping a copy of a time-consuming operation locally so that you don't have to redo the expensive operation again if the inputs and outputs are going to be exactly the same. Caches are usually key value stores, where the value is the answer to the expensive operation and the key is something that's unique to that item. If you request a page from the server and then request the same page from the server again, the quickest way to get that request fulfilled is to actually keep a copy of what you got last time locally. Browsers cache lots of the responses they get to requests they've made by using the headers that get sent with the response. The headers tell the browser how long the page remains 'fresh' before it 'expires.' Once the page has expired, the browser will make a new request for the page to refresh its cache. We say that the fastest request is the request that's not made. It's also often said that cache invalidation is one of the two hard problems in computer science, so think carefully when you start caching things! Caching saves bandwidth for us and provides a speed boost for the user. This is great until you change the file and you want all of your users to get the new one instead of the old version they have stored in their browser cache. But how do we let the browser know we've modified the file? If the new version has the same name as the old version, the browser will continue using the old file from its cache. We need a way to change the filename when the contents change so that browsers won't keep serving the old file.

### From the [Rails Guides Primer](http://guides.rubyonrails.org/asset_pipeline.html#what-is-fingerprinting-and-why-should-i-care-questionmark)
"Fingerprinting is a technique that makes the name of a filename dependent on the contents of the file. When the file contents change, the filename is also changed. For content that is static or infrequently changed, this provides an easy way to tell whether two versions of a file are identical, even across different servers or deployment dates.

When a filename is unique and based on its content, HTTP headers can be set to encourage caches everywhere (whether at CDNs, at ISPs, in networking equipment, or in web browsers) to keep their own copy of the content. When the content is updated, the fingerprint will change. This will cause the remote clients to request a new copy of the content. This is known as cache busting.

The technique sprockets uses for fingerprinting is to append a hash of the content to the end of the file name. For example, take a CSS file named `global.css`. Sprockets will add the hash `908e25f4bf641868d8683022a5b62f54` to the end of the file name like so:
```
global-908e25f4bf641868d8683022a5b62f54.css
```

If you happen to be using an older version of Rails (Rails 2.x), the strategy used to be to append a date-based query string to every asset linked with a built-in helper. This looked like so:
```
global.css?1309495796
```

The query string strategy has several disadvantages:

- Not all caches will reliably cache content where the filename only differs by query parameters.
    + Steve Souders recommends "avoiding a querystring for cacheable resources." 5-20% of your requests will not be cached. Query strings in particular do not work at all with some CDNs for cache invalidation.
- The file name can change between nodes in multi-server environments.
    + The default query string in Rails 2.x is based on the modification time of the files. When assets are deployed to a cluster, there is no guarantee that the timestamps will be the same, resulting in different values being used depending on which server handles the request.
- Too much cache invalidation.
    + When static assets are deployed with each new release of code, the mtime (time of last modification) of all these files changes, forcing all remote clients to fetch them again, even if the content of those assets has not changed.

Fingerprinting fixes all these problems by ensuring that filenames are consistent based on their content.

Fingerprinting is enabled by default for production and disabled for all other environments. You can enable or disable it in your configuration through the `config.assets.digest` option."

## Conclusion
The Asset Pipeline is definitely more complex then just serving assets from a public folder and it can be hard to debug. Learning how to use it will pay off in the long run by saving us time and headaches. Just think about all the problems it solves for us.

1. Asset Paths
2. Manifests and Concatenation
3. Preprocessing
4. Fingerprinting

Finally, definitely check out the [keynote where DHH introduces the asset pipeline](https://www.youtube.com/watch?v=cGdCI2HhfAU).

## Resources
* [Rails Guides Primer](https://github.com/learn-co-curriculum/what-is-the-asset-pipeline/edit/master/README.md) 

