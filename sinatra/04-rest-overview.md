## REST Architecture

Any app which intends to make available a resource via REST should include the following URL schema (Rails 2.0 was the first web framework to use such a schema)

1. GET /photos #=> index, list all examples of the resource
2. GET /photos/1 #=> show, show the particular resource based on id

3. GET /photos/new #=> new, should present a form allowing the user to create a new item(calls POST /photos on submission)
4. POST /photos #=> create, adds the new item to the application

5. GET /photos/1/edit #=> edit, present a form allowing the user to edit the item(calls PUT /photos/1 on submission)
6. PUT /photos/1 #=> update, updates the item in the app

7. DELETE /photos/1 #=> destroy, delete the item from the app
