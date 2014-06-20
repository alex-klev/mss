var MongoStore, bodyParser, cookieParser, express, methodOverride, path, session;

methodOverride = require('method-override');

cookieParser = require('cookie-parser');

bodyParser = require('body-parser');

express = require('express');

session = require('express-session');

MongoStore = require('connect-mongo')(session);

path = require('path');

module.exports = function(app) {
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded());
  app.use(methodOverride('_method'));
  app.use(cookieParser());
  app.use(express["static"](path.join(__dirname, './../../public')));
  app.use(session({
    secret: 'MSS_SECRET',
    store: new MongoStore({
      db: 'mss'
    })
  }));
  app.use(function(req, res, next) {
    var err, msg;
    err = req.session.error;
    msg = req.session.success;
    delete req.session.error;
    delete req.session.success;
    res.locals.message = '';
    if (err) {
      res.locals.message = err;
    }
    if (msg) {
      res.locals.message = msg;
    }
    return next();
  });
  return app.use(function(req, res, next) {
    if ((req.url === '/') || /(^\/landing)/.test(req.url)) {
      app.set('activeMenu', '/');
      return next();
    }
    app.set('activeMenu', req.url.replace(/(^(\/+)?)/, '').replace(/(\/[\s\S]*$)/, ''));
    return next();
  });
};
