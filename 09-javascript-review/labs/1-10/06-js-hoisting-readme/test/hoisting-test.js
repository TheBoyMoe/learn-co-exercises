/*global afterEach, beforeEach, describe, it */

'use strict';

const chai = require('chai')
const fs = require('fs')
const jsdom = require('mocha-jsdom')
const path = require('path')
const spies = require('chai-spies')

chai.use(spies)

const expect = chai.expect

describe('hoisting', () => {
  jsdom({
    src: fs.readFileSync(path.resolve(__dirname, '..', 'hoisting.js'), 'utf-8')
  })

  describe('callMe', () => {
    it("returns the string 'maybe'", () => {
      expect(callMe()).to.equal("maybe");
    })
  })

  describe('loggers', () => {
    beforeEach(() => {
      chai.spy.on(console, 'log')
    })

    afterEach(() => {
      console.log.reset()
    })

    describe('crazy', () => {
      it("prints 'hey!!!' to the console from the nested function", () => {
        crazy()

        expect(console.log).to.have.been.called.with("hey!!!")
      })
    })

    describe('sayMyName', () => {
      it("prints 'Kristin' to the console from the nested function", () => {
        sayMyName()
        expect(console.log).to.have.been.called.with("Kristin")
      })
    })
  })
})
