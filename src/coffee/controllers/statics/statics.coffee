#mongoose = require 'mongoose'
#Posts    = mongoose.model 'Posts'

StaticController = {}

StaticController.get =

  showIndex: (req, res)->
    res.render 'users/index'



module.exports = StaticController