#mongoose = require 'mongoose'
#Posts    = mongoose.model 'Posts'

StaticController = {}

StaticController.get =

  index: (req, res)->
    res.render 'users/static/index'

  landing: (req, res)->
    res.render 'users/static/landing',
      landing: true

  remont: (req, res)->
    res.render 'users/static/remont'

  materialy: (req, res)->
    res.render 'users/static/materialy'

  gallery: (req, res)->
    res.render 'users/static/gallery'

  price: (req, res)->
    res.render 'users/static/price'

  login: (req, res)->
    res.render 'users/static/login'


StaticController.post =

  login: (req, res, next)->
    console.log req.body
    if !req.body.login or !req.body.password
      err = new Error 'Forbidden'
      err.status = 403
      return next(err)
    res.redirect '/admin/'

module.exports = StaticController