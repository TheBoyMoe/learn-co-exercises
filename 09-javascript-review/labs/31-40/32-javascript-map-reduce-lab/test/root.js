global.expect = require('expect');
global.cheerio = require('cheerio');

const fs = require('fs');
const jsdom = require('mocha-jsdom');
const path = require('path');
const babel = require('babel-core');

const html = fs.readFileSync(path.resolve(__dirname, '..', 'index.html'), 'utf8');

const babelResult = babel.transformFileSync(path.resolve(__dirname, '..', 'index.js'), {
  presets: ['es2015']
});

jsdom({
  html,
  src: babelResult.code
});
