mongoose = require 'mongoose'
Posts    = mongoose.model 'Posts'

PostsController = {}

PostsController.get =

  showIndex: (req, res, next)->
    Posts.find {}, (err, posts)->
      return next err if err
      res.render 'users/posts', {
        posts: posts
      }

  showId: (req, res, next)->
    res.render 'users/post', {
        post: req.post
      }

PostsController.post =

  new: (req, res, next)->
    post = new Posts()
    post.title = 'Some title'
    post.html  = '<div>Bla Bla</div>'
    post.save (err)->
      console.log err if err
      res.send 'One added!'


PostsController.param =
  findByChpu: (req, res, next, id)->
    id = id.split '_'
    if id.length is 2
      Posts.findOne {_id: id[1]}, (err, post)->
        return next err if err
        return next(new Error('not found')) if !post
        req.post = post
        next()
    else
      next(new Error('not found'))






module.exports = PostsController