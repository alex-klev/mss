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
    var err;
    err = new Error('Forbidden');
    err.status = 403;
    err.message = 'Неверный login или password';
    if (!req.body.login || !req.body.password) {
      return next(err);
    }
    return User.findOne({
      login: req.body.login
    }, function(e, user) {
      if (e) {
        return next(e);
      }
      if (!user) {
        return next(err);
      }
      if (!user.authenticate(req.body.password)) {
        return next(err);
      }
      return res.redirect('/admin/');
    });
  }
};

module.exports = StaticController;
