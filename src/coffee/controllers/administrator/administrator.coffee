mongoose = require 'mongoose'
Posts    = mongoose.model 'Posts'

AdminController = {}

AdminController.showIndex = (req, res, next)->
  res.render 'admin/index'

AdminController.Posts =
  all: (req, res, next)->
    Posts.find {}, (err, posts)->
      return next err if err
      res.render 'admin/posts/all', {
        posts: posts
      }

  show: (req, res)->
    res.render 'admin/posts/one', {
      post: req.post
    }

  create: (req, res, next)->
    post = new Posts(req.body)
    post.save (err)->
      console.log err if err
      res.redirect('/admin/posts/')

  update: (req, res, next)->
    console.log req.body
    if req.body.active then req.body.active = true else req.body.active = false
    Posts.findOneAndUpdate {_id: req.params.id}, req.body, {new: false}, (err)->
      return next(err) if err
      res.redirect('/admin/posts/')

  delete: (req, res, next)->
    Posts.findOneAndRemove {_id: req.params.id}, (err)->
      return next(err) if err
      res.redirect('/admin/posts/')



AdminController.param =

  id: (req, res, next, id)->
    Posts.findOne {_id: id}, (err, post)->
      return next err if err
      return next(new Error('not found')) if !post
      req.post = post
      next()



module.exports = AdminController