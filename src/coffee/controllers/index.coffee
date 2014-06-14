administrator    = require './administrator'
statics          = require './statics'
posts            = require './posts'


module.exports = (app)->
  app.use '/', statics
  app.use '/posts', posts

  app.use '/admin', administrator
  return