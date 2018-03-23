describe('Selectors', () => {
  it('getIt() binds a click event to the paragraph', function() {
    window.alert = expect.createSpy()

    window.getIt();

    window.$('p')[0].click()

    expect(window.alert).toHaveBeenCalled();
  });

  it('frameIt() binds an event that frames the minion when the page loads', function() {
    window.frameIt()

    const img = window.$('img')

    img.trigger('load');

    expect(img.attr("class")).toEqual("tasty");
  });

  describe('pressIt()', () => {
    it('pressIt() binds an event that alerts the user when the G key was pressed down', function() {
      window.alert = expect.createSpy()

      window.pressIt();

      const input = window.$('#typing');
      const event = window.$.Event('keydown', { which: 71 })
      input.trigger(event)

      expect(window.alert).toHaveBeenCalled()
    })

    it('does not alert if another key is pressed', () => {
      window.alert = expect.createSpy()

      window.pressIt();

      const input = window.$('#typing');
      const event = window.$.Event('keydown', { which: 70 })
      input.trigger(event)

      expect(window.alert).toNotHaveBeenCalled()
    })
  })

  it('submitIt() binds an event that alerts "Your form is going to be submitted now." when the form is submitted', function() {
    window.alert = expect.createSpy()

    window.submitIt();

    const form = window.$('form')[0]

    window.$(form).trigger('submit')

    expect(window.alert).toHaveBeenCalledWith('Your form is going to be submitted now.');
  });

});
