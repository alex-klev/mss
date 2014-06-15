var StaticController;

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
    console.log(req.body);
    if (!req.body.login || !req.body.password) {
      err = new Error('Forbidden');
      err.status = 403;
      return next(err);
    }
    return res.redirect('/admin/');
  }
};

module.exports = StaticController;
