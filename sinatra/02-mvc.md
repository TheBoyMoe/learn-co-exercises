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
