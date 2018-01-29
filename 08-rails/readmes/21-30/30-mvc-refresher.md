# Refresher on MVC

## Overview

We'll review the concepts of MVC and learn some new key concepts.

## Objectives

1. Understand the value of placing logic in expected places.
2. Know what *presentation logic* is and how it differs from *business
   logic*.

## Separation of Concerns

Separation of Concerns is a design principle that helps us keep code logically organized by ensuring that each part of an application concerns itself with a specific job.

Remember the restaurant analogy? In a restaurant, there is a separation of concerns among the staff. A *server* takes your order, a *cook* prepares your order, a *food runner* brings it to your table, and a *busser* cleans up after you — and all of them work together to provide the cohesive experience of eating out.

Sure, the cook could do everything. In a small restaurant with only a few customers, it might be manageable for the same person who takes your order to be the one who cooks it. But, if that restaurant is bigger than, say, a food truck, there's a good chance that things would get out of control, and the cook would never know what she or he is supposed to do at any given time. Likewise, nobody else at the restaurant would know what the cook is supposed to be doing, and everyone would go looking for the cook for *everything*, which seems like kind of a nightmare!

## Model-View-Controller Review

In Rails, the Model-View-Controller paradigm helps us separate our concerns and know where to put certain kinds of code.

We could put all of our code in one file, but then the file is in the same spot as that overworked cook — doing so much that nobody knows what it's supposed to be doing. In a tiny application with only one developer, this might work for a while, but as the application and the team grow everyone needs to know where to go to find certain kinds of code.

With that in mind, let's look again at the components of the MVC pattern:

+ **Models:** Provide the *business logic* of the application and access and store data. Models do most of the 'heavy lifting' of manipulating data and enforcing the 'rules' of the application.
+ **Views:** Provide the *presentation logic* of the application and allow for user interaction. Views only care about showing a user formatted data and giving them ways to interact with it.
+ **Controllers:** Provide communications between the models and the views and help *control* the flow of data.

Okay, models are responsible for *business logic* and views are responsible for *presentation logic*, but what does that mean?

**Business logic** is the code that deals with the data and the "business" or "real-world" rules that govern an application. This is also sometimes called *domain* logic because it's all the stuff that's specific to the domain of the application. Sticking with the restaurant analogy, the business logic governs things like recipes and prices and how old you have to be to order a margarita.

**Presentation logic** is the code that deals with what the user sees. If business logic tells us what food the restaurant has and how much it costs, presentation logic puts all that together into a menu that looks great and helps a customer choose what to eat (and also entices them to order that margarita).

To put that into context with Rails MVC, picture a blog application. The view is only concerned with the presentation of blog posts. That's what it knows how to do, and that's all it knows how to do. The model is concerned with the content of all of the posts. The controller is concerned with which blog post you want to see. By keeping them separate, we get to do things like create a single view that can be used to display any post by having the controller ask for a specific post from the model.

By knowing which component is responsible for which concern, we can know where to go to find or add code based on what it does. If we need to write code to hit the database and search for specific blog posts, that seems like business logic and belongs in the model. If we need to write code to display those search results in a nice way and make sure the post date is formatted properly, that's presentation logic and belongs in the view.

## Separating Even More Concerns

We know the view is responsible for presentation logic, but what happens when our application grows and some presentation logic needs to be shared across more than one view? That's where `helpers` come in, and we'll be tackling those in the next lesson.
