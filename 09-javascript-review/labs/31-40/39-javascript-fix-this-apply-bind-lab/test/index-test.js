describe('index', function() {
  describe('cake', function() {
    it('has a decorate function', function() {
      expect(cake.decorate).toExist()
    })
  })

  describe('makeDessert', function() {
    it('calls the right function', function() {
      var pieNode = document.getElementById("pie")
      var cakeNode = document.getElementById("cake")
      var makeCakeSpy = expect.spyOn(makeCake, "call")
      var makePieSpy = expect.spyOn(makePie, "call")
      makeDessert.call(pieNode.getElementsByClassName("js-make")[0])
      makeDessert.call(cakeNode.getElementsByClassName("js-make")[0])
      expect(makePieSpy).toHaveBeenCalledWith(pieNode)
      expect(makeCakeSpy).toHaveBeenCalledWith(cakeNode)
      makeCakeSpy.restore()
      makePieSpy.restore()
    })
  })

  describe('makeCake', function() {
    it('binds an update function', function() {
      var spy = expect.spyOn(updateStatus, "bind").andCallThrough()
      var node = document.getElementById("cake")
      makeCake.call(node)
      expect(spy).toHaveBeenCalledWith(node)
      spy.restore()
    })

    it('calls mix with context', function() {
      var update = updateStatus.bind(document.getElementById("cake"))
      var spy = expect.spyOn(mix, "call").andCallThrough()
      var node = document.getElementById("cake")
      makeCake.call(node)
      expect(spy).toHaveBeenCalledWith(cake, update)
      spy.restore()
    })
  })

  describe('pie', function() {
    it('borrows the decorate function from cake', function() {
      var spy = expect.spyOn(cake.decorate, "bind").andCallThrough()
      makePie.call(document.getElementById("pie"))
      expect(pie.decorate).toExist()
      expect(spy).toHaveBeenCalledWith(pie)
    })
  })

  describe('makePie', function() {
    it('binds an update function', function() {
      var spy = expect.spyOn(updateStatus, "bind").andCallThrough()
      var node = document.getElementById("pie")
      makePie.call(node)
      expect(spy).toHaveBeenCalledWith(node)
      spy.restore()
    })

    it('calls mix with context', function() {
      var update = updateStatus.bind(document.getElementById("pie"))
      var spy = expect.spyOn(mix, "call").andCallThrough()
      var node = document.getElementById("pie")
      makePie.call(node)
      expect(spy).toHaveBeenCalledWith(pie, update)
      spy.restore()
    })
  })

  describe('cook functions', function() {
    before(function() {
      let useFakeTimers = null

      if (typeof sinon === 'undefined') {
        useFakeTimers = require('sinon').useFakeTimers;
      } else {
        useFakeTimers = sinon.useFakeTimers
      }

      this.clock = useFakeTimers();
    })

    after(function() {
      this.clock.restore()
    })

    let update;

    before(function() {
      update = updateStatus.bind(document.getElementById("pie"))
    })

    describe('mix', function() {
      it('calls the update function', function() {
        mix.call(pie, update)
        expect(
          document.getElementById("pie").getElementsByClassName("status")[0].innerText
        ).toMatch(/Mixing/)
      })

      it('calls bake with context', function() {
        var bakeSpy = expect.spyOn(bake, "call")

        mix.call(pie, update)

        this.clock.tick(3000)

        expect(bakeSpy).toHaveBeenCalledWith(pie, update)
        bakeSpy.restore()
      })

    })

    describe('bake', function() {
      it('calls the update function', function() {
        bake.call(pie, update)
        expect(
          document.getElementById("pie").getElementsByClassName("status")[0].innerText
        ).toMatch(/Baking at/)
      })

      it('calls cool with context', function() {
        var coolSpy = expect.spyOn(cool, "call")

        bake.call(pie, update)

        this.clock.tick(3000)

        expect(coolSpy).toHaveBeenCalledWith(pie, update)
        coolSpy.restore()
      })
    })

    describe('cool', function() {
      it('calls the update function', function() {
        cool.call(pie, update)
        expect(
          document.getElementById("pie").getElementsByClassName("status")[0].innerText
        ).toMatch(/cool!/)
      })

      it('calls decorate with context', function() {
        pie.decorate = cake.decorate.bind(pie)
        var decorateSpy = expect.spyOn(pie, "decorate")

        cool.call(pie, update)

        this.clock.tick(3000)

        expect(decorateSpy).toHaveBeenCalledWith(update)
        decorateSpy.restore()
      })
    })

    describe('decorate', function() {
      it('it applies serve with correct args', function() {
        var serveSpy = expect.spyOn(serve, "apply")

        cake.decorate(update)

        this.clock.tick(3000)

        expect(serveSpy).toHaveBeenCalledWith(
          cake,
          ["Happy Eating!", cake.customer]
        )
      })
    })
  })
})
