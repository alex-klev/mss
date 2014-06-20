methodOverride = require 'method-override'
cookieParser   = require 'cookie-parser'
bodyParser     = require 'body-parser'
express        = require 'express'
session        = require 'express-session'
MongoStore     = require('connect-mongo')(session)
path           = require 'path'

module.exports = (app)->
  app.use bodyParser.json()
  app.use bodyParser.urlencoded()
  app.use methodOverride('_method')
  app.use cookieParser()
  app.use express.static(path.join(__dirname, './../../public'))

  app.use session
    secret: 'MSS_SECRET',
    store: new MongoStore db: 'mss'

  app.use (req, res, next)->
    err = req.session.error
    msg = req.session.success
    delete req.session.error
    delete req.session.success
    res.locals.message = ''
    res.locals.message = err if err
    res.locals.message = msg if msg
    return next()

  app.use (req, res, next)->
    if (req.url is '/') or /(^\/landing)/.test(req.url)
      app.set 'activeMenu', '/'
      return next()
    app.set 'activeMenu', req.url.replace(/(^(\/+)?)/, '').replace(/(\/[\s\S]*$)/, '')
    return next()