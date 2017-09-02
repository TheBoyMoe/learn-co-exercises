## MVC

Model View Controller, MVC, is an architectural design pattern used to separate the major components of the app - separation of concerns.(business logic, C, data, M, presentation layer, V). It is a popular design paradigm used to build web app. Promotes ease of maintenance, code re-use and testing.

The original, Small-Talk, implementation of MVC:

 * Model - the business logic of the app. This is where data is manipulated and saved.

 * View - the UI, the only part that the user interacts with. It captures user input and relays it the the controller. No processing here. Consists of the html/css/js files of your web page.

 * Controller - the go-between. It's function is to relay messages between the view and model layers, since these two layers never communicate directly.


The view receives user input, which is passed to the controller, which in turn forwards the request to the model. Here any processing is carried out, before the response is passed back to the controller which forwards it to the view to be displayed. This led to the notion of the SMART model, THIN controller and DUMB view. Latterly, in some MVC patterns, more of the business logic has been moved into the controller - leading to the idea of the GOD class.

### Implementing MVC with Sinatra

The basic mvc roles are implemented thus:

 * models are generally ruby classes which may or may not connect to a database to persist data. The model contains the main logic of your app.

 * views are implemented through .erb files, html files with embedded ruby.

 * controllers are written in ruby and consist of routes. They represent the requests received from the browser, GET, POST, etc. They run code based on these requests, controller actions, and then render the erb/view file.


#### What does a Sinatra MVC File Structure Look Like?

A simple file/directory structure would look like:

```bash
├── Gemfile
├── README.md
├── app
│   ├── controllers
│   │   └── application_controller.rb
│   ├── models
│   │   └── model.rb
│   └── views
│       └── index.erb
├── config
│   └── environment.rb
├── config.ru
├── public
│   └── stylesheets
└── spec
    ├── controllers
    ├── features
    ├── models
    └── spec_helper.rb
```

Gemfile - lists all req'd gems. The 'bundle install' command, provided by the 'bundler' gem, will install all of these together with any dependencies. A Gemfile.lock file is also created. This has the versions of the gems used, so if the app is distributed or re-installed later, the same gem versions are used. It also ensures that only one thing can run 'bundle install' at a time.

app directory - contains folders for our models, views and controllers.

models directory - represents the data or object logic behind the app. Typically, these files represent a component of the app, e.g. Post, User, etc, or a unit of work. Each file being a different class.

views directory - contains the .erb files responsible for creating the view displayed by the browser. By convention each file is named after the action that renders them.

controllers directory - represents the app logic, the 'flow' of the app. Are where the apps configurations (tells the controller where to find views and the public directory), controllers and routes are found. There is typically the 'ApplicationController' that represents the application when the server is running and inherits from 'Sinatra::Base'. This can be the 'app.rb' or 'application_controller.rb' file.

When a client makes a request to a server to load an application, the request is received and processed by the controller - the 'controller action' processes the request and respond with the appropriate view.

config.ru - responsible for loading our application environment, code, and libraries. It then specifies which controllers to load as part of our application using 'run' or 'use', 'run ApplicationController' creates an instance of our ApplicationController class that responds to requests from a client.

config directory - contains 'environment.rb' file - responsible loading bundler(and this all gems) and the app's environment.

public directory - holds all he front end assets, e.g css, js and image files.

spec directory - contains any tests, subdivided into models, features and controllers.
