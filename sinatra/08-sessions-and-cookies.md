## Sessions and Cookies

Http is a stateless protocol, each request is an independent transaction and thus unable to use information of previous requests. In order to track what page a user is on, what items are in their cart, or whether a user is logged in and return them back to the same page we rely on a combination of cookies and sessions:
  - Cookies are hashes that store data, sent by the server regarding the http request, in the client browser as a text file. Each request the server sends information to the client, in each subsequent request the client sends the cookie is sent back to the server. They're visible only to the server that created them.
  - Sessions are hashes that store data about a client's interactions with a web page at a particular moment in time that are stored on the server side.

A web server will use cookies and session data to keep track of a client's interaction with a particular site. When you send a request to facebook.com, the application on the server will generate and store some data about you. The application will keep that data in a session hash, and it will also create a cookie that is sent back to the client and stored in their browser. These persist until they expire or are deleted. Upon any subsequent visits to the same website, the cookies are sent back. At that pint the cookie data is compared to the server-side session data(if it exists) and decides how to respond.


### Cookies

Cookies will contain:
  - the websites' url
  - date created, and expiry
  - any info pertinent the the particular site the server wants saved, e.g. user preferences, login information.

There are two types:

**Session cookies** allow the server to keep track of your movement from page to page on that particular visit. Once logged in, a session cookie allows you to navigate through a site without to having to repeatedly authenticate on every new page you visit within the web application domain. Session cookies expire every time you log out or navigate away from the website.

Without a session cookie if you were to add an item to your cart, you you were to then navigate to any other page, that that information would be lost.

**Persistent cookies** are used to store user preferences and information for future visits, such as usernames to to enable speeder authentication, and user preferences. They're used to improve the user's experience of using the site.

A persistent cookie is stored on your computer, while a session cookie is temporarily stored in your web browser. They're typically created on the first visit, after you have created an account on the site, and typically persist unless either the web application has a protocol in place for cookie expiration or the user clears their browser's cache.
