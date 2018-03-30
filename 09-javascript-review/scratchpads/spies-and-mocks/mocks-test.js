// stub out jquery's get() method
describe('getCharacters()', function () {
  it('should get the characters from an external API', function () {
    const spy = sinon.spy()
    // $ is the jquery object we call the get method on
    const fakeGet = sinon.stub($, 'get')
    fakeGet.yields()

    getCharacters(spy)
    expect(spy.calledOnce).toBeTruthy()
  })
})


// Using mocks
// test sendPrefsToStorage() - mock
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