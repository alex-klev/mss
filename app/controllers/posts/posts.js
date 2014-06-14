var Posts, PostsController, mongoose;

mongoose = require('mongoose');

Posts = mongoose.model('Posts');

PostsController = {};

PostsController.get = {
  showIndex: function(req, res, next) {
    return Posts.find({}, function(err, posts) {
      if (err) {
        return next(err);
      }
      return res.render('users/posts', {
        posts: posts
      });
    });
  },
  showId: function(req, res, next) {
    return res.render('users/post', {
      post: req.post
    });
  }
};

PostsController.post = {
  "new": function(req, res, next) {
    var post;
    post = new Posts();
    post.title = 'Some title';
    post.html = '<div>Bla Bla</div>';
    return post.save(function(err) {
      if (err) {
        console.log(err);
      }
      return res.send('One added!');
    });
  }
};

PostsController.param = {
  findByChpu: function(req, res, next, id) {
    id = id.split('_');
    if (id.length === 2) {
      return Posts.findOne({
        _id: id[1]
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
    } else {
      return next(new Error('not found'));
    }
  }
};

module.exports = PostsController;
