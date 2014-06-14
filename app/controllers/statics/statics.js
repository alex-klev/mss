var StaticController;

StaticController = {};

StaticController.get = {
  showIndex: function(req, res) {
    return res.render('users/index');
  }
};

module.exports = StaticController;
