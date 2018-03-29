global.expect = require('expect')
global.sinon = require('sinon')

const fs = require('fs')
const jsdom = require('mocha-jsdom')
const path = require('path')

jsdom({
  src: fs.readFileSync(path.resolve(__dirname, '..', 'index.js'), 'utf-8'),
  html: fs.readFileSync(path.resolve(__dirname, '..', 'index.html'), 'utf-8')
})
