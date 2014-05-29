var app, bodyParser, cookieParser, express, favicon, logger, path, routes, users;

cookieParser = require('cookie-parser');

bodyParser = require('body-parser');

favicon = require('static-favicon');

express = require('express');

logger = require('morgan');

path = require('path');

routes = require('./routes/index');

users = require('./routes/users');

app = express();

app.set('views', path.join(__dirname, './../views'));

app.set('view engine', 'jade');

app.use(favicon());

app.use(logger('dev'));

app.use(bodyParser.json());

app.use(bodyParser.urlencoded());

app.use(cookieParser());

app.use(express["static"](path.join(__dirname, './../public')));

app.use('/', routes);

app.use('/users', users);

app.use(function(req, res, next) {
  var err;
  err = new Error('Not Found');
  err.status = 404;
  next(err);
});

if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});

module.exports = app;

/*
//# sourceMappingURL=app.js.map
*/
