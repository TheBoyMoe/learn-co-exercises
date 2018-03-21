const fs = require('fs');
const path = require('path');

const jsdom = require('mocha-jsdom');

const chai = require('chai');
const expect = chai.expect;
const spies = require('chai-spies');
chai.use(spies);

describe('index.js', () => {
  jsdom({
    src: fs.readFileSync(path.resolve(__dirname, '..', 'index.js'), 'utf-8')
  });

  describe('doToElementsInArray()', () => {
    it('is defined', () => {
      expect(doToElementsInArray).to.be.a('function');
    });

    it('invokes the passed-in callback function on every element of the passed-in array using Array.prototype.forEach()', () => {
      const callback = function(fruit) {
        return `Mmmm, ${fruit}!!!`;
      };

      const array = ["apple", "banana", "cherry"];
      const forEach = chai.spy.on(array, 'forEach');

      doToElementsInArray(array, callback);

      expect(forEach).to.have.been.called.with(callback);
    });
  });

  describe('changeCompletely()', () => {
    it('is defined', () => {
      expect(changeCompletely).to.be.a('function');
    });

    it('alters every element in an array when used in conjunction with Array.prototype.forEach()', () => {
      const array = ["antelope", "bear", "cat"];

      array.forEach(changeCompletely);

      expect(array[0]).not.to.eql("antelope");
      expect(array[1]).not.to.eql("bear");
      expect(array[2]).not.to.eql("cat");
    });
  });
});
