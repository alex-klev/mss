var bodyParser, cookieParser, express, methodOverride, path;

methodOverride = require('method-override');

cookieParser = require('cookie-parser');

bodyParser = require('body-parser');

express = require('express');

path = require('path');

module.exports = function(app) {
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded());
  app.use(methodOverride('_method'));
  app.use(cookieParser());
  app.use(express["static"](path.join(__dirname, './../../public')));
  return app.use(function(req, res, next) {
    if ((req.url === '/') || /(^\/landing)/.test(req.url)) {
      app.set('activeMenu', '/');
      return next();
    }
    app.set('activeMenu', req.url.replace(/(^(\/+)?)/, '').replace(/(\/[\s\S]*$)/, ''));
    return next();
  });
};
