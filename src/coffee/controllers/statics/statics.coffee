mongoose = require 'mongoose'
User     = mongoose.model 'User'

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
    err = new Error 'Forbidden'
    err.status = 403
    err.message = 'Неверный login или password'
    if !req.body.login or !req.body.password
      return next(err)

    User.findOne login: req.body.login, (e, user)->
      return next e if e
      return next err if !user
      return next err if !user.authenticate req.body.password
      return res.redirect '/admin/'

module.exports = StaticController