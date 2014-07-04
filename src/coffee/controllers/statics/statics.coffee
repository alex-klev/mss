mongoose = require 'mongoose'
User     = mongoose.model 'User'
log      = require('./../../helpers/log')(module)

error401 = new Error 'Unauthorized'
error401.status = 401

StaticController = {}

StaticController.get =

  index: (req, res)->
    res.render 'users/static/index'

  landing: (req, res)->
    res.render 'users/static/landing', landing: true

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

#  gena: (req, res, next)->
#    admin = new User login: 'admin', password: '12345'
#    admin.save (err, info)->
#      return next err if err
#      res.redirect '/'


StaticController.post =

  login: (req, res, next)->
    error401.url = req.url
    error401.msg = error401.message + ' | ' + req.body.login + ':' + req.body.password

    if !req.body.login or !req.body.password
      req.session.error = 'Неверный login или password'
      log.error err:error401
      return res.status(401).render 'users/static/login'

    User.findOne login: req.body.login, (err, user)->
      return next err if err

      if !user
        req.session.error = 'Неверный login или password'
        log.error err:error401
        return res.status(401).render 'users/static/login'

      if !user.authenticate req.body.password
        req.session.error = 'Неверный login или password'
        log.error err:error401
        return res.status(401).render 'users/static/login'

      req.session.regenerate ()->
        req.session.user = user
        req.session.success = 'Добро пожаловать, ' + user.login
        return res.redirect 'back'

module.exports = StaticController