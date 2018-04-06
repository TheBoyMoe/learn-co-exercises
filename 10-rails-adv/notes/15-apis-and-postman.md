# APIs and Postman

## Objectives

1. Use Postman to explore an API
2. Read API documentation
3. Understand the value of and how to use Client IDs and Secrets


## Lesson

We're going to explore the Foursquare API and learn how to read API documentation.

### Tools

The first thing we want to do is install a couple of tools to make our lives a lot easier.

[Postman](https://www.getpostman.com/) is a Chrome app that we can use to easily make API requests. Check out the docs and install the app from [here](https://www.getpostman.com/docs/).

[JSONView](https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc) is a Chrome extension that will automatically make JSON data much more readable in Chrome.

### Foursquare Venue API

Okay, let's try to get venue data on Foursquare. We'll check out the [Venues endpoint](https://developer.foursquare.com/docs/venues/venues) in the documentation.

Here's how we read this page:

**Venue Detail** is the name of the function, or *endpoint*, that we are going to use, and its URI takes the format: `https://api.foursquare.com/v2/venues/VENUE_ID`. This RESTful URI looks a lot like one we'd use in a Rails app to allow access to a given venue.

The document tells us that we will need to access this endpoint with the HTTP `GET` verb, and that `VENUE_ID` is a parameter that we will need to provide.

**Top-tip:** Generally speaking, you will use `GET` for endpoints that are read-only, and `POST`, for endpoints that alter data, but be sure to read the documents carefully because not every API is implemented the same.

It then links to a *response* documentation that tells us each field we can expect in the JSON response, and what it means.

Enough talk, let's try it! In your browser address bar, enter `https://api.foursquare.com/v2/venues/40a55d80f964a52020f31ee3` and see what we get.

Oh. We get an error code.


### API Credentials

If we'd paused to read the [introductory documentation](https://developer.foursquare.com/start), we'd see that we need to create an app on Foursquare to use the API. Creating an app will give us a *client ID* and a *secret* that we can use as credentials for the API.

Most API providers require a similar process to use their API. Even though you can publicly access much of this data through the website, API providers want to know who is accessing their API. There are several reasons for this, but an important one is quality control.

Let's say one bad application is using the API in unintended ways, perhaps making too many requests in a short period of time. This is problematic because it can negatively affect other API users who are behaving appropriately. By requiring a client ID/secret authorization, Foursquare can know who the offender is and turn off their access, ensuring quality for other API users.

Okay, but why can't we just log in to Foursquare with our normal account and use it that way?

While there are some functions in an API that may require an individual user to be authenticated, the client ID/secret pair authorizes the *application* access the API. You wouldn't want to embed your personal account information in the application, allowing users to perform actions as if they were you, would you?

This client ID/secret pair isn't actually a "login". It's just a way of securely identifying and allowing an application to make requests.

Let's follow the instructions to [create a Foursquare app](https://foursquare.com/developers/apps) so that we can get a client ID and secret, then.

**Hint:** You can use `http://localhost:3000` as your web address.

Once you've created your app, you should see your Client ID and Client Secret on your app page. 

### A Full API Request

Now that we have them, we can try that request again with our app credentials. Enter the URL with your client id and secret into your browser:

`https://api.foursquare.com/v2/venues/40a55d80f964a52020f31ee3?client_id=YOUR_CLIENT_ID&client_secret=YOUR_SECRET&v=20160201&m=foursquare`

If you put in your client ID and secret, you should see some JSON that looks like this:

```javascript
response: {
  venue: {
    id: "40a55d80f964a52020f31ee3",
    name: "Clinton St. Baking Co. & Restaurant",
    contact: {
    phone: "6466026263",
    formattedPhone: "(646) 602-6263"
  },
  location: {
    address: "4 Clinton St",
    crossStreet: "at E Houston St",
    lat: 40.72107924768216,
    lng: -73.98394256830215,
    postalCode: "10002",
    cc: "US",
    city: "New York",
    state: "NY",
    country: "United States",
    formattedAddress: [
      "4 Clinton St (at E Houston St)",
      "New York, NY 10002",
      "United States"
    ]
  },
// ...
```

**Note:** Remember that with a `GET` request, we pass parameters via a *querystring* by putting a `?` after the url and then formatting parameters like this: `param=value&param2=value`.

Typing all that into the URL bar of our browser every time is tedious and makes it easy to make a mistake, so we can use Postman, which will make it much easier to deal with parameters, headers, and anything else we might need to do to explore an API.

Open postman, then enter the base URL in the URL field: `https://api.foursquare.com/v2/venues/40a55d80f964a52020f31ee3`. Then click `Params`, and you can enter each parameter separately below. Enter the following three things in the appropriate columns:

| URL Parameter Key |     Value      |
|-------------------|----------------|
| client_id         | YOUR CLIENT ID |
| client_secret     | YOUR SECRET    |
| v                 | 20160201       |
| m                 | foursquare     |

We'll talk about what `v` and `m` do in a minute. Hit "Send", and you should get the same JSON result that we did in the browser. 

### API Versioning

The `v` parameter we passed in was a version parameter that the Foursquare API requires. Try taking it out by deleting the `v` parameter and value from Postman and hitting "Send" again.

You should see an error about the API requiring a version parameter. You can read the included [link](https://developer.foursquare.com/overview/versioning) to learn more.

Similarly, the `m` parameter indicates which style of response we want back from the server — Foursquare or Swarm. Both apps are accessible via the same API, so it's important to choose.

So what is versioning?

Versioning is an important tool in API use. When an API changes, either because of new features or changed endpoints, not all API clients will be able to keep up with those changes immediately. If you just changed the API and released it, any application using the API would run the risk of being broken until they updated their code.

This is akin to the problem we discovered with screen scraping when the website changes.

By versioning the API, you can guarantee that anyone using the current version can keep using it and upgrade to the new version when they are able to. You leave the old endpoints in place (e.g. `https://api.foursquare.com/v1/venues`) and roll out a new one under a new version namespace (e.g. `https://api.foursquare.com/v2/venues`). This way everyone on `v1` can keep working, and the API provider doesn't break every application that uses the site.

In Foursquare's case, they require the `v` parameter as a way of you saying "I am prepared for code as of this date". This versioning parameter becomes a form of contract between the API provider and consumer.

## Summary

We've looked at consuming an API with Postman, using an application Client ID/Secret to authorize your API calls, and the importance of API versioning.

Spend some time poking around the Foursquare API documentation and use Postman to try out the various endpoints.

