# Javascript Manifests Lab

## Objectives

1. Create Javascript Manifest Files
2. Require Javascript Files in Manifests with Sprocket Directives
3. Include Javascript Manifest Files in Layouts

## Outline
Located in the lab repository is a simple Rails application called `javascript_manifest_rails`. Your job is to assemble two valid JavaScript manifest files, one for the Admin layout and one for the Application layout. There is also a file we're currently trying to load that's causing an error.  Figure out how to fix it.  To see the error load the homepage in the browser.

### Application Layout
- Create an application manifest with some of the js files found throughout the applications valid javascript asset directories.  Add `alert_maker.js` and `main.js`.  Move `wrong_place_wrong_time.js` into the correct directory and load it as well.
- Load your manifest into the application layout.

### Admin Layout
- Load `hello_world.js`, `doesn_nothing.js` in the admin manifest.
- Load your manifest into the admin layout. 
- Add an additional `javascript_include_tag` to the admin layout and use it to load `main.js`.

When you finish, start the rails server with `rails server` and browse to http://localhost:3000 for the Application layout and http://localhost:3000/admin for the Admin layout. If you open Chrome dev tools and go to the elements tab, you should see the files you included in your manifest files as script tags in the head tag.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/javascript-manifests-lab' title='Javascript Manifests Lab'>Javascript Manifests Lab</a> on Learn.co and start learning to code for free.</p>
