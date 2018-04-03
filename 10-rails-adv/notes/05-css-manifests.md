# CSS Manifests

## Objectives

1. Create CSS Manifest Files
2. Require CSS Files in Manifests with Sprocket Directives
3. Include CSS Manifest Files in Layouts
4. See a Manifest in Development vs. Production

## Overview
CSS makes our web applications look good but can be hard to manage. As our application grows, so do the amount of stylesheets we need to manage. The Asset Pipeline can help us manage this chaos much like with JavaScript.

### Manifest Files

Like our JavaScript manifest, the CSS manifest has a special syntax that differentiates it from a regular CSS file. The `*= require` directive is very similar to its JS counterpart. We are just using a CSS comment instead of a JS comment.

```
/*
*= require main
*/
```

_Note_: In a CSS manifest file you must open the CSS comment block with `/*` and then each directive appears on an individual line starting with `*=`. You close the comment block with `*/`. It's a little different than the JS directive comments of `//=`, which are individual, valid JS comments.

### `require` directives

When we require a CSS asset in our manifest, if it is located in one of the configured folders, it will be included in our application. One thing to remember is when you require something the path you provide must be the asset path. For example, if you have the file `app/assets/stylesheets/blogs/main.css` you will need to require it like this, `*= require 'blogs/main'`.

### Loading a Manifest File in your layout

Loading our CSS manifest file into our application is just as easy as it was with JS. We create a `stylesheet_link_tag` in our application layout, and Sprockets takes care of loading the manifest and determining which assets to include.

```erb
<%= stylesheet_link_tag 'application' %>
```

In development mode, each CSS file will get its own link tag. This allows for easier debugging. A manifest file that looks like this:

```css
/*
*= require main
*= require blogs
*= require posts
*/
```

Would create this in our application layout's head tag (assuming fingerprinting/digests are turned off):

```html
  <link rel="stylesheet" href="/assets/main.css" /> 
  <link rel="stylesheet" href="/assets/blogs.css" /> 
  <link rel="stylesheet" href="/assets/posts.css" /> 
```

#### Manifests in Production
In production mode, Sprockets will take all of our CSS files and create one large CSS file. It will also [minify](https://developers.google.com/speed/docs/insights/MinifyResources) the contents, removing unneeded whitespace to reduce the overall size of the file. Both of these things will speed up page load times for our users. If we look at our previous manifest example:

```css
/*
*= require main
*= require blogs
*= require posts
*/
```

We would only get a single link tag from this in our application manifest.

```html
<link rel="stylesheet" href="/assets/application-4dd5b109ee3439da54f5bdfd78a80473.css" /> 
```
The CSS in this file would look like this:
```css
body{background-color:#FFF;font-size:14px;margin:0}a{color:#1B97F2;text-decoration:none}.clear{clear:both}ul{margin:4px 0;padding-left:17px}ul.horizontal{list-style:none;margin:0;padding:0}ul.horizontal li{margin:0;padding:0;float:left}#flash_notice,#flash_alert{padding:10px 0;text-align:center;color:#FFF}
```
Notice the lack of whitespace? That's the minification we talked about earlier. This is great for production use, but it's a bit hard to read. This is why when we are in development mode we get individual, unminified files instead.

## Resources
- https://github.com/rails/sprockets#sprockets-directives
- http://guides.rubyonrails.org/asset_pipeline.html

