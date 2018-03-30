# Mocks and Stubs

## Objectives

1. Define a stub
2. Define a mock
3. Explain when to use mocks and stubs
4. Explain when you might want to avoid mocks and stubs

## What are stubs?
While spies wrap existing functionality, stubs allow us to replace the functionality completely.
The original function won't run anymore, but rather our new stub that simply returns a result. This
is especially handy if we want to test async stuff that makes use of things like jQuery's AJAX methods.

For example, let's take a look at this code:

```js
function getCharacters(callback) {
  $.get('http://api.example.com/characters', callback);
}
```

This seems easy enough, but async code like this gets really hard to test. What we'll do instead is
stub jQuery's `.get()` method — this way it doesn't make any external requests for the purposes of
our test. This makes our test a lot faster and super stable.

```js
describe('getCharacters()', function () {
  it('should get the characters from an external API', function () {
    const spy = sinon.spy();
    const fakedGet = sinon.stub($, 'get');
    fakedGet.yields();
    
    getCharacters(spy);
    expect(spy.calledOnce).toBeTruthy();
  });
});
```

Using stubs, it's also really easy to test our code for edge cases. What happens when the request
fails, or sends back unexpected data? Stubbing the method like this gives us absolute control over
the data that is returned through the `$.get()` method, making testing for this stuff trivial.

## What are mocks?
Mocks are the end-all of fake methods. They're kind of like spies, but they also have stubbed
behavior (much like stubs), **and** contain 'pre-programmed expectations'. That just means that we
tell the mock what to expect up front.

Let's assume that we have some kind of storage mechanism that saves a user's preferences:

```js
const userStorage = {
  saveRemainLoggedInPreference(remainLoggedIn) {
    // Save the `remainLoggedIn` preference in some way
  },
  saveLanguagePreference: (language) => {
    // Save the `language` preference in some way
  }
};
```

Now, we have some other code that makes use of this function to save the options in the UI to the
storage:

```js
function sendPrefsToStorage({ remainLoggedIn, language }) {
  storage.saveRemainLoggedInPreference(remainLoggedIn);
  storage.saveLanguagePreference(language);
}

$('#prefs-submit').on('click', function () {
  const remainLoggedIn = $('#remain-logged-in').is(':checked');
  const language = $('#language-selector').val();
  sendPrefsToStorage({ remainLoggedIn, language });
});
```

Let's test the `sendPrefsToStorage()` method. We'll mock our `storage` since we're interested in
verifying our function, and not the logic of `storage` itself:

```js
describe('sendPrefsToStorage', function() {
  it('should save the preferences in storage', function() {
    var storageMock = sinon.mock(storage);
    storageMock.expects('saveRemainLoggedInPreference').once().withArgs(true);
    storageMock.expects('saveLanguagePreference').once().withArgs('en-US');

    sendPrefsToStorage({ remainLoggedIn: true, language: 'en-US' });

    storageMock.restore();
    storageMock.verify();
  });
});
```

As you can see, it's easy to mock both methods on the `storage` object using Sinon's mock. However,
it is important that we **only mock what we actually need**. Mocking too much stuff will lead to
brittle tests.


## Avoiding stubs and mocks
The best kind of code is modular with most of its functions being pure (remember, a pure function is
a function that determines its return value only by its input values, without any side-effects). As
such, it's easier to test our actual implementations piece by piece rather than relying on stubs and
mocks.

Stubs and mocks are still useful for testing the annoying async parts or mocking out methods
in a library, but they should be used very sparingly.

## Resources
- [Best Practices for Spies, Stubs, and Mocks in Sinon.js](https://semaphoreci.com/community/tutorials/best-practices-for-spies-stubs-and-mocks-in-sinon-js)