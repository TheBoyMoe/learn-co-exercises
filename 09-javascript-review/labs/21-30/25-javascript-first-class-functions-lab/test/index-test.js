describe('index', function() {
  describe('`countdown` function', function () {
    before(function() {
      let useFakeTimers = null;

      if (typeof sinon === 'undefined') {
        useFakeTimers = require('sinon').useFakeTimers;
      } else {
        useFakeTimers = sinon.useFakeTimers;
      }

      this.clock = useFakeTimers();
    })

    after(function() {
      this.clock.restore();
    });

    it('should exist', function () {
      expect(countdown).toExist()
    });

    it('should have call the given callback function after two seconds', function() {
      const spy = expect.createSpy();
      countdown(spy);

      expect(spy).toNotHaveBeenCalled();

      this.clock.tick(2001);

      expect(spy).toHaveBeenCalled();
    });
  });

  describe('`createMultiplier` function', function () {
    it('should exist', function () {
      expect(createMultiplier).toExist();
    });

    it('should return a function', function () {
      const doubler = createMultiplier(2);
      expect(doubler).toBeA('function');
    });

    it('should multiply a given value using the created multiplier', function () {
      const doubler = createMultiplier(2);
      expect(doubler(5)).toEqual(10);
    });
  });

  describe('Multiplier functions created with `createMultiplierBonus`', function () {
    it('should have a doubler function', function () {
      expect(doubler).toExist();
      expect(doubler).toBeA('function');
      expect(doubler(5)).toEqual(10);
    });

    it('should have a tripler function', function () {
      expect(tripler).toExist();
      expect(tripler).toBeA('function');
      expect(tripler(5)).toEqual(15);
    });
  });

  describe('`multiplier()` with partial application', function () {
    it('should exist', function () {
      expect(multiplier).toExist();
    });

    it('should have a doubler function created using `.bind()`', function () {
      if (typeof server !== 'undefined' && server && !hasUsedBind) {
        throw new Error("No cheating! Make sure to use `.bind()` for this solution!");
      }

      expect(doublerWithBind).toExist();
      expect(doublerWithBind).toBeA('function');

      expect(triplerWithBind).toExist();
      expect(triplerWithBind).toBeA('function');
    });
  });
});
