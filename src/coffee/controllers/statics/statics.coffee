mongoose = require 'mongoose'
User     = mongoose.model 'User'

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
    if !req.body.login or !req.body.password
      req.session.error = 'Неверный login или password'
      return res.redirect '/login'

    User.findOne login: req.body.login, (err, user)->
      return next err if err

      if !user
        req.session.error = 'Неверный login или password'
        return res.redirect '/login'

      if !user.authenticate req.body.password
        req.session.error = 'Неверный login или password'
        return res.redirect '/login'

      req.session.regenerate ()->
        req.session.user = user
        req.session.success = 'Добро пожаловать, ' + user.login
        return res.redirect 'back'

module.exports = StaticController