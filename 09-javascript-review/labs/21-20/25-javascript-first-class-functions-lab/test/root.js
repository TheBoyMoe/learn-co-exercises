global.expect = require('expect');

const fs = require('fs');
const jsdom = require('mocha-jsdom');
const path = require('path');

const src = fs.readFileSync(path.resolve(__dirname, '..', 'index.js'), 'utf-8');


// FIXME: (pletcher) These are hacks to keep one of
// the tests running; they obviously won't run in
// the client, which could be frustrating for students
global.hasUsedBind = src.indexOf('.bind(') !== -1;
global.server = true

jsdom({ src });
