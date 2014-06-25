mongoose = require 'mongoose'
Posts    = mongoose.model 'Posts'
log      = require('./../../helpers/log')(module)
longPoll = require './longpolling'

AdminController = {}

AdminController.showIndex = (req, res, next)->
  res.render 'admin/index'

AdminController.Posts =
  all: (req, res, next)->
    Posts.find {}, (err, posts)->
      return next err if err
      res.render 'admin/posts/all', posts: posts

  show: (req, res)->
    res.render 'admin/posts/one', post: req.post

  create: (req, res, next)->
    post = new Posts(req.body)
    post.save (err)->
      return next err if err
      res.redirect '/admin/posts/'

  update: (req, res, next)->
    if req.body.active then req.body.active = true else req.body.active = false
    Posts.findOneAndUpdate _id: req.params.id, req.body, new: false, (err)->
      return next err if err
      res.redirect '/admin/posts/'

  delete: (req, res, next)->
    Posts.findOneAndRemove _id: req.params.id, (err)->
      return next err if err
      res.redirect '/admin/posts/'

AdminController.Logs =
  show: (req, res, next)->
    options = from: new Date - 24 * 60 * 60 * 1000, until: new Date, limit: 20, start: 0, order: 'desc', fields: ['message', 'err', 'url', 'timestamp']
    log.query.error options, (err, logs)->
      return next err if err
      res.render 'admin/logs', logs: logs.mongodb

  subscribe: (req, res, next)->
    longPoll.subscribe req, res

AdminController.param =

  id: (req, res, next, id)->
    Posts.findOne _id: id, (err, post)->
      return next err if err
      if !post
        err = new Error 'Post:_id not found'
        err.status = 404
        return next err
      req.post = post
      next()



module.exports = AdminController