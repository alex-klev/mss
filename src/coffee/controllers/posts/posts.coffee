mongoose = require 'mongoose'
Posts    = mongoose.model 'Posts'

PostsController = {}

error404 = new Error 'not found'
error404.status = 404

PostsController.get =

  showIndex: (req, res, next)->
    page = parseInt(req.params.page or 1)
    return next() if page < 1
    skip = 5 * (page - 1)

    posts = null
    Posts.find {}, null, {skip: skip, limit: 5}
    .exec()
    .then (_posts)->
      throw error404 if !_posts.length
      posts = _posts
      return Posts.count().exec()
    .then (count)->
      res.render 'users/posts',
        posts: posts
        pages: Math.ceil count / 5
        page : page
    .then null, (err)->
      return next err if err

  showId: (req, res, next)->
    res.render 'users/post',
        post: req.post

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
        return next(error404) if !post
        req.post = post
        next()
    else
      next(error)

  onlyDigits: (req, res, next, id)->
    if /^\d+$/.test(id)
      return res.redirect(301, '/posts/') if id is '1'
      return next()
    else
      return next(error404)






module.exports = PostsController