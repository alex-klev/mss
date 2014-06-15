var Menu, app, bodyParser, connect, cookieParser, debug, express, favicon, fs, logger, methodOverride, modelsPath, mongoose, path;

methodOverride = require('method-override');

cookieParser = require('cookie-parser');

bodyParser = require('body-parser');

mongoose = require('mongoose');

favicon = require('static-favicon');

express = require('express');

logger = require('morgan');

path = require('path');

debug = require('debug')('app');

fs = require('fs');

app = express();

app.set('views', path.join(__dirname, './../views/template'));

app.set('view engine', 'jade');

app.use(favicon());

app.use(logger('dev'));

app.use(bodyParser.json());

app.use(bodyParser.urlencoded());

app.use(methodOverride('_method'));

app.use(cookieParser());

app.use(express["static"](path.join(__dirname, './../public')));

connect = function() {
  var options;
  options = {
    server: {
      socketOptions: {
        keepAlive: 1
      }
    }
  };
  return mongoose.connect('mongodb://localhost/mss', options);
};

connect();

mongoose.connection.on('error', function(err) {
  return debug(err);
});

mongoose.connection.on('disconnected', function() {
  return connect();
});

modelsPath = path.join(__dirname, './models');

fs.readdirSync(modelsPath).forEach(function(file) {
  if (~file.indexOf('.js')) {
    return require(modelsPath + '/' + file);
  }
});

Menu = mongoose.model('Menu');

app.use(function(req, res, next) {
  if (!app.get('menu')) {
    return Menu.find({}).exec(function(err, menu) {
      var gallary, main, post, price, remont;
      if (err) {
        gebug(err);
        throw err;
      }
      if (!menu.length) {
        main = new Menu({
          title: 'Главная',
          href: '/'
        });
        remont = new Menu({
          title: 'Ремонт',
          href: '/remont/'
        });
        post = new Menu({
          title: 'Статьи',
          href: '/posts/'
        });
        gallary = new Menu({
          title: 'Галерея',
          href: '/gallery/'
        });
        price = new Menu({
          title: 'Цены',
          href: '/price/'
        });
        main.save(function() {
          return remont.save(function() {
            return post.save(function() {
              return gallary.save(function() {
                return price.save(function() {});
              });
            });
          });
        });
        menu = [main, remont, post, gallary, price];
      }
      app.set('menu', menu);
      return next();
    });
  } else {
    return next();
  }
});

app.use(function(req, res, next) {
  if ((req.url === '/') || /(^\/landing)/.test(req.url)) {
    app.set('activeMenu', '/');
    return next();
  }
  app.set('activeMenu', req.url.replace(/(^(\/+)?)/, '').replace(/(\/[\s\S]*$)/, ''));
  return next();
});

require('./controllers')(app);

app.use(function(req, res, next) {
  var err;
  err = new Error('Not Found');
  err.status = 404;
  next(err);
});

if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('errors/error', {
      message: err.message,
      error: err
    });
  });
}

app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('errors/error', {
    message: err.message,
    error: {}
  });
});

module.exports = app;
