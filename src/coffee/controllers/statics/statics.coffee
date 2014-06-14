#mongoose = require 'mongoose'
#Posts    = mongoose.model 'Posts'

StaticController = {}

StaticController.get =

  index: (req, res)->
    res.render 'users/static/index'

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

module.exports = StaticController