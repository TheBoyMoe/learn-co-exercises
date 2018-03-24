global.expect = require('expect')

const fs = require('fs')
const jsdom = require('jsdom')
const path = require('path')
const html = fs.readFileSync(path.resolve(__dirname, '..', 'index.html'), 'utf-8')
const scripts = [
  path.resolve(__dirname, '..', 'js', 'events.js')
]

const virtualConsole = jsdom.createVirtualConsole();

virtualConsole.on("log", function (message) {
  console.log("console.log called ->", message);
})

before(function(done) {
  global.window = jsdom.jsdom(html, { scripts, virtualConsole }).defaultView

  jsdom.jQueryify(window, "http://code.jquery.com/jquery-2.1.1.js", () => {
    done()
  })
})
