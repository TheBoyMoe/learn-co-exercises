const chai = require('chai')
const fs = require('fs')
const jsdom = require('mocha-jsdom')
const path = require('path')
const spies = require('chai-spies')

chai.use(spies)

const expect = chai.expect

describe('index', () => {
  jsdom({
    src: fs.readFileSync(path.resolve(__dirname, '..', 'index.js'), 'utf-8')
  })

  describe('forEach(iterable, callback)', () => {
    describe('with an array', () => {
      it('uses `Array.isArray`', () => {
        const isArray = chai.spy.on(Array, 'isArray')
        const array = [1, 2, 3]

        forEach(array, () => {})

        expect(isArray).to.have.been.called
      })

      it('calls `callback` on each element of the array', () => {
        const spy = chai.spy()
        const array = [1, 2, 3]

        forEach(array, spy)

        expect(spy).to.have.been.called.exactly(3)
      })
    })

    describe('with an object', () => {
      it('calls `callback` on each key-value pair', () => {
        const spy = chai.spy()
        const object = { foo: 'bar', puppy: 'fido' }

        forEach(object, spy)

        expect(spy).to.have.been.called.exactly(2)
      })
    })
  })
})
