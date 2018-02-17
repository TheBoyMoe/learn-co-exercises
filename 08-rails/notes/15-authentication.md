## Authentication

### Cookies and Sessions

Cookies are used by clients to store information about the current session locally
	- a http session is stateless, the server does not 'remember' the user, so the cookie is sent with each subsequent request
	- primarily used for login, they provide a way to verify the user for the entire session(otherwise you would have to provide your credentials every request)
	- can also be used to store info about the user, e.g. contents of a cart, what ads they've been shown
	- although cookies are stored in the browser in plain text, in Rails any key/value pairs saved to a `session` are serialized to a string which is then cryptographically signed when the cookie is set preventing it from being read or tampered with.
	- Rails allows you to save any simple Ruby object to the session, wheich is available anywhere in the response cycle 
	