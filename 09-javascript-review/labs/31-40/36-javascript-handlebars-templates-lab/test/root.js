global.expect = require('expect');

const babel = require('babel-core');
const fs = require('fs');
const jsdom = require('jsdom');
const path = require('path');


before(function(done) {
  const babelResult = babel.transformFileSync(path.resolve(__dirname, '..', 'index.js'), {
    presets: ['es2015']
  });

  const html = fs.readFileSync(
    path.resolve(__dirname, '..', 'index.html'),
    'utf-8'
  );

  jsdom.env(html, [], {src: babelResult.code}, (err, window) => {
    if (err) {
      return done(err);
    }

    window.Handlebars = require('handlebars');

    Object.keys(window).forEach(key => {
      global[key] = window[key];
    });

    return done();
  });
});
