var StaticController;

StaticController = {};

StaticController.get = {
  index: function(req, res) {
    return res.render('users/static/index');
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
    console.log(req.body);
    if (!req.body.login || !req.body.password) {
      return next(new Error('403 Forbidden'));
    }
    return res.redirect('/admin/');
  }
};

module.exports = StaticController;
