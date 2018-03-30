# Introduction to REST

## Objectives

1. Explain the history of REST
2. Explain the main actions involved in RESTful architectures
3. Describe the relationship between REST and HTTP

## Introduction

In 2000, Roy Thomas Fielding was frustrated by the hap-hazard different ways web applications were using the HTTP standard. Specifically he was frustrated with how URLs and their corresponding HTTP Verbs were used differently for every single application. So, in his PhD dissertation he came up with REST or REpresentational State Transfer as a standard way web apps should structure their URLs. It also suggested a few other things, but we focus mostly on how it changed URLs. Fielding also noticed the rise in web applications communicating with each other. Using this standard way of forming URLs to access resources, Fielding hoped that inter-application communication would get much easier.

There is a good chance that you have already worked with RESTful APIs. Integrating a Facebook login, getting repository data from Github, having something in your application post to Twitter, pulling in a feed of images from Instagram, or even calling a list of locations from Google Maps are all examples of using a RESTful API to communicate between applications.

## Example REST Workflow

At root, RESTful systems are centered on the idea of a *resource*. You
can think of a resource in the same way you'd think of an object in your
code, and in fact, most times a RESTful resource represents a domain
object in your system, like a `product` or a `customer`.

For a real world case study, let's pretend that you have a newsletter application. The following is a high level view on how REST works in your app:

1. You open the page that has the blank form that you use to make a new
   newsletter. In terms of REST, this page represents a request for a `new resource`.

2. You fill out the form on the 'New Newsletter' page and click submit.
   Information about you, your newsletter content and any additional
information such as media items are all sent to the application server.
The server takes all this information and saves it to the database,
creating your newsletter. RESTfully speaking, this server action is `create resource`.

3. After the server saves your newsletter, it redirects you to the page
   where you can view your newly-created newsletter. This is `show resource` in a RESTful system.

4. You decide you want to change the title of your newsletter, so you
   browse to the page that has the filled-in, editable form for your
newsletter. Requesting this page is requesting to `edit resource`.

5. You change the title and submit the form. On the server, the new
   information is applied to your newsletter record. This action is
`update resource`.

6. Finally, you want to browse all the newsletters to see what else you
   could subscribe to. Asking for the list of all newsletters is asking
for the `index` of the resource.

## RESTful Conventions

There are certain conventions that most RESTful systems follow, whether they are a user-facing web application or purely an API. Most systems follow a standard pattern for routing the types of requests we talked about above.

Let's take a look at a practical example of how this works. If you wanted to build out a Newsletter feature we would need the system to have four key actions: Create, Read, Update, and Destroy – commonly known as CRUD actions. In addition to the CRUD actions, we will also need an `index` page that lists out all of our newsletters – that's five routes. Since our users will need to have a visual interface for creating and updating records (a form for creating and another form for updating), we will need two more routes. Putting all of that together, we end up with seven different routes.

## HTTP Verbs and REST

For routes that render content to the browser, or are considered *read-only* (that is, they don't change data on the server), we use the HTTP `GET` verb. With a `GET` request, we *get* a view of a resource. These are the routes that we typically use when we click links.

If a route results in a change to data, we use different verbs based on the action.

If a new resource is being created, we use `POST`. A `POST` method
encloses some data with the request that the server will use to create
the requested resource.

If an existing resource is being updated, like changing the title of our newsletter, we use `PATCH`. Similar to `POST`, `PATCH` encloses data in the request that will be used to identify the existing resource and update its attributes.

If we want to destroy a resource, we use the `DELETE` verb. A `DELETE`
request will include the resource identifier so it can be found and
deleted.

**Note:** Sometimes you'll see `PUT` interchangeably with `PATCH`.
Technically speaking, `PUT` should only be used if an entire resource is
being replaced, whereas `PATCH` is used to update a resource, but these
things have evolved over time, so pay close attention to the
documentation of any APIs you're working with. The reality is that you
can do any job with any verb, for instance, you could design an API that
uses `GET` requests for destroy actions, but generally we want to try to
follow these conventions as best we can to avoid confusion and reveal
intent with our APIs.

## Routes

Routes are simply the combination of an HTTP verb and a URI. When we
create a system, we have to define the routes by which people will
access our resources.

Armed with an understanding of which verbs are for which actions, here is what our newsletter application's routes might look like.

```js
GET      /newsletters 				     # Show all newsletters
POST     /newsletters          	 	 # Create a new newsletter
GET      /newsletters/new          # Render the form for creating a new newsletter
GET      /newsletters/:id/edit 	   # Render the form for editing a newsletter
GET      /newsletters/:id      	   # Show a specific newsletter
PATCH    /newsletters/:id          # Update a newsletter
DELETE   /newsletters/:id          # Delete a newsletter
```

Let's examine a few of these in more detail.

It makes sense that `/newsletters` shows the collection of all
newsletters, but why is the create action also `/newsletters` and not
something like `/newsletters/create`?

RESTful routing is all about mapping routes to resources in a way that
makes semantic sense. In this case, what are we really doing when we
create a newsletter? We are adding a new item to the collection of all
newsletters. So if the proper route to view all newsletters is `get
/newsletters`, then it makes sense, semantically, that the proper route
to create a new entry in the collection of all newsletters would be
`POST /newsletters`.

Similarly, we have three routes that are all pointing to
`/newsletters/:id`. This is why we use different verbs to do different
actions. Because showing, updating, and deleting a newsletter are all
actions on the same resource, it makes sense that they'd have the same
path, `/newsletters/:id`, and use the different verbs to represent the
action being taken.

## Nested Routes

We often need to access resources as they relate to parent resources,
and our RESTful routes can support that. The generic convention looks
like this: `/parent/:id/children/:id/:action`, using the same verbs for the same actions as we would a non-nested
route.

As an example, let's say our newsletter had an `id` of 17. Every week,
when we send out our newsletter, we create a new `entry`. How would we
expect to interact with the entries of our newsletter in a RESTful
system?

```js
GET      /newsletters/:id/entries 		 # Show all entries for a newsletter
POST     /newsletters/:id/entries      # Create a new newsletter entry
GET      /newsletters/:id/entries/new  # Render the form for creating a new entry
GET      /entries/:id/edit 	           # Render the form for editing an entry
GET      /entries/:id      	           # Show a specific entry
PATCH    /entries/:id                  # Update an entry
DELETE   /entries/:id                  # Delete an entry
```

Here, when we want to see all entries of a newsletter, we go through
`/newsletters/:id/entries` to get there, because we want to filter our
results to just the one newsletter.

Similarly, when we create a new entry, it has to be associated with a
newsletter, so it makes sense to have those routes also go through the
parent `/newsletters/:id` route.

However, when it gets down to acting on a single entry, we can just go
directly to the entry. We don't need the parent newsletter to `PATCH` an
entry or `GET` an entry or `DELETE` an entry, because we are operating
on the individual resource.

Looking at these routes, we can start to see that the way we set up our
RESTful URLs becomes a reflection of the rules of our system. If we
don't want people to look at an index of all entries without the context
of a parent newsletter, we don't define a `GET /entries` route. If we
want to force people to always be in the context of a parent newsletter
when viewing a single entry, we would replace that `GET /entries/:id`
route with `GET /newsletters/:id/entries/:entry_id`. And if we wanted to
allow both, we could have both routes.

Every choice you make when designing a RESTful API defines how someone
uses the system, so choose wisely!

## Summary

Below are a few keys to remember when thinking about REST:

* REST is an architectural design pattern, not a framework or code in itself. Many web frameworks utilize RESTful design principles in some form or another. By using RESTful principles, our apps are able to have a clear and standardized naming structure for routes and actions.

* RESTful routes have a clear mapping between the URL resource and the corresponding controller actions.

* Using the appropriate HTTP verb is key to differentiating the purpose
  of routes with the same URI.

## Resources

- [Representational state transfer](https://en.wikipedia.org/wiki/Representational_state_transfer)