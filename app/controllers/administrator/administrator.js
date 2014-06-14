var AdminController, Posts, mongoose;

mongoose = require('mongoose');

Posts = mongoose.model('Posts');

AdminController = {};

AdminController.showIndex = function(req, res, next) {
  return res.render('admin/index');
};

AdminController.Posts = {
  all: function(req, res, next) {
    return Posts.find({}, function(err, posts) {
      if (err) {
        return next(err);
      }
      return res.render('admin/posts/all', {
        posts: posts
      });
    });
  },
  show: function(req, res) {
    return res.render('admin/posts/one', {
      post: req.post
    });
  },
  create: function(req, res, next) {
    var post;
    post = new Posts(req.body);
    return post.save(function(err) {
      if (err) {
        console.log(err);
      }
      return res.redirect('/admin/posts/');
    });
  },
  update: function(req, res, next) {
    console.log(req.body);
    if (req.body.active) {
      req.body.active = true;
    } else {
      req.body.active = false;
    }
    return Posts.findOneAndUpdate({
      _id: req.params.id
    }, req.body, {
      "new": false
    }, function(err) {
      if (err) {
        return next(err);
      }
      return res.redirect('/admin/posts/');
    });
  },
  "delete": function(req, res, next) {
    return Posts.findOneAndRemove({
      _id: req.params.id
    }, function(err) {
      if (err) {
        return next(err);
      }
      return res.redirect('/admin/posts/');
    });
  }
};

AdminController.param = {
  id: function(req, res, next, id) {
    return Posts.findOne({
      _id: id
    }, function(err, post) {
      if (err) {
        return next(err);
      }
      if (!post) {
        return next(new Error('not found'));
      }
      req.post = post;
      return next();
    });
  }
};

module.exports = AdminController;
