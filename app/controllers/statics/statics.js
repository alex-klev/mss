var StaticController, User, mongoose;

mongoose = require('mongoose');

User = mongoose.model('User');

StaticController = {};

StaticController.get = {
  index: function(req, res) {
    return res.render('users/static/index');
  },
  landing: function(req, res) {
    return res.render('users/static/landing', {
      landing: true
    });
  },
  remont: function(req, res) {
    return res.render('users/static/remont');
  },
  materialy: function(req, res) {
    return res.render('users/static/materialy');
  },
  gallery: function(req, res) {
    return res.render('users/static/gallery');
  },
  price: function(req, res) {
    return res.render('users/static/price');
  },
  login: function(req, res) {
    return res.render('users/static/login');
  }
};

StaticController.post = {
  login: function(req, res, next) {
    if (!req.body.login || !req.body.password) {
      req.session.error = 'Неверный login или password';
      return res.redirect('/login');
    }
    return User.findOne({
      login: req.body.login
    }, function(err, user) {
      if (err) {
        return next(err);
      }
      if (!user) {
        req.session.error = 'Неверный login или password';
        return res.redirect('/login');
      }
      if (!user.authenticate(req.body.password)) {
        req.session.error = 'Неверный login или password';
        return res.redirect('/login');
      }
      return req.session.regenerate(function() {
        req.session.user = user;
        req.session.success = 'Добро пожаловать, ' + user.login;
        return res.redirect('back');
      });
    });
  }
};

module.exports = StaticController;
