# Images and the Asset Pipeline

## Objectives

1. Add images to the Rails Asset Pipeline
2. Construct image asset URLs.
3. Use asset_path and asset_url helpers.
4. Use image_tag helpers

## Outline
Most web applications have images. Just like JavaScript and Stylesheets, the Asset Pipeline makes dealing with images easier. The Asset Pipeline helps us build paths and deal with caching problems.

## Where do images go?
Where do we put our images so the Asset Pipeline can find them? We can put them in the `app/assets/images` directory. By default, this path is already included in the asset paths. It's possible to add more image paths to the asset paths by adding to `Rails.application.assets.paths`. Once the additional path has been added, we can access it using the standard `/assets` url. The cool thing here is we can use one URL path that maps to a bunch of different folders. For example the URL "/assets/logo.png" will look in all the folders in the asset paths for that image, but no matter where it's located its URL never changes.

If you pop open the console and type in `Rails.application.assets.paths` you'll see an array of the paths Rails considers to be asset paths. So technically, you could add an image to `assets/stylesheets` and Rails would find it, but that would be confusing to your coworkers. Because it's an array, you can easily shovel in more directories if you have images in places not on the list. In your `application.rb` you could do something like this.

```ruby
#application.rb
config.assets.paths << Rails.root.join("lib", "myrandomimagefolder")
```

## `asset_path` Helper
The first of the helpers available to help us create image paths is the `asset_path` helper. It provides a way for us to get a relative path to an image file in the Asset Path. To use this helper, we specify the path relative to the assets folder.

```ruby
asset_path('logo.png')
```

If the asset pipeline finds the file, it will return the path to the
image.

```
/assets/logo.png
```

If the file is in a sub-folder in the images directory (images/banner), we need to include that as well.

```ruby
asset_path('banner/logo.png')
```

```
/assets/banner/logo.png
```

If the asset pipeline can't find the file, the path returned will be `/` plus the file name.

```
/logo.png
```

The `asset_path` helper is great for image paths located in our CSS files.

```css
.logo {
  background-image: url(<%= asset_path('logo') %>);
}
```

## `image_tag` Helper
Most of the time we don't only care what the URL is for an image, we want to generate an HTML tag that will actually display the image for a user.
The `image_tag` helper creates an `<img>` tag with the path to the image.

```html
<%= image_tag "logo.png" %>
```

Will create:

```html
<img src="/assets/logo.png" />
```

If the asset pipeline can't find the file, an image tag will be created with the name of the file plus the '/' path.

```html
<img src="/logo.png" />
```

Since this image doesn't exist we will see a broken image on our web page.

## Fingerprinting
Just like with our JS and CSS, browser caching can cause problems when we decide to update an image. When we use either `asset_path` or `image_tag` to display our images, the Asset Pipeline will add a fingerprint to the file. This will only happen if we are running our application with fingerprinting on. By default it's on in both production and development. If you want to turn it off you can go to the environment file `config/environment/development.rb` and change `config.assets.digest = false`.

If we were to look at one of these paths, it would look like this:

```
/assets/logo-331238805bdaebb4b05e9385bc1261f8.png
```

A digest is appended to the file name. If the file is updated, the digest will change. We won't have to worry about users having old versions of image files when we make changes.

## Image Tags
It is possible to predict the path to a image file and create our own image tag. This is not recommended since it will limit your ability to move your file and avoid caching problems that the helpers fix. ALWAYS USE THE HELPERS.

