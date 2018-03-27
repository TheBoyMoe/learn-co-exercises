global.expect = require('expect');

const fs = require('fs');
const jsdom = require('mocha-jsdom');
const path = require('path');

const src = path.resolve(__dirname, '..', 'index.js');
const babelResult = require('babel-core').transformFileSync(src, {
  presets: ['es2015']
});

jsdom({
  src: babelResult.code,
  html: fs.readFileSync(path.resolve(__dirname, '..', 'index.html'), 'utf-8')
});
