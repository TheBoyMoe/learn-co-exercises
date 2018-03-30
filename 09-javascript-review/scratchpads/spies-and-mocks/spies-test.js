// we want to verify that the subscribe()function is called every time the store data changes

// we'll create a store in our test, and then create a spy. We'll pass that spy to the subscribe() function provided by the store. Afterwards, we'll set data on the store and verify that our spy has been called the correct amount of times.

describe('store', function () {
  it("should call a listener every time the store data updates", function () {
    const store = createStore()
    const spy = sinon.spy()

    store.subscribe(spy)
    store.setData('flavour', 'vanilla')
    expect(spy.calledOnce).toBeTruthy()
    store.setData('flavour', 'strawberry')
    expect(spy.calledTwice).toBeTruthy()
  })
})


// Verify that sayHello() works as intended
describe('welcomePersonAtTheDoor()', function () {
  it('should call the sayHello() function', function () {
    const spy = sinon.spy(window, 'sayHello')
    welcomePersonAtTheDoor({firstName: george})
    expect(spy.calledOnce).toBeTruthy()
  })
})
