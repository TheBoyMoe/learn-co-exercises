const expect = chai.expect;
spyOnNumberIsInteger.restore();

describe('index.js', function () {
  describe('newID', function () {
    it('converts IDs from the old style to the new style', function () {
      expect(newID).to.eq(1000000000 + oldID);
    });
  });

  describe('ageIsValid', function () {
    it("contains 'true' when the value in 'currentAge' is a valid integer", function () {
      if (currentAgeIsInteger) {
        expect(ageIsValid).to.be.true;
      } else {
        expect(ageIsValid).to.be.false;
      }
    });

    it("invokes 'Number.isInteger()'", function () {
      expect(spyOnNumberIsInteger.calledOnce).to.be.true;
    });
  });

  describe('randomNumber', function () {
    it('contains a random number greater than or equal to 0 and less than 20', function () {
      expect(randomNumber).to.be.at.least(0).but.below(20);
    });

    it("invokes 'Math.random()'", function () {
      expect(spyOnMathRandom.calledOnce).to.be.true;
    });
  });

  describe('randomInteger', function () {
    it("contains the value of 'randomNumber' rounded down to the nearest integer", function () {
      const flooredRandomInteger = Math.floor(randomNumber);

      expect(randomInteger).to.eql(flooredRandomInteger);
    });
  });

  describe('randomUserID', function () {
    it('contains a random integer between 1000000001 and 1000000020', function () {
      expect(Number.isInteger(randomUserID)).to.be.true;

      expect(randomUserID).to.be.at.least(1000000001).and.at.most(1000000020);
    });
  });
});
