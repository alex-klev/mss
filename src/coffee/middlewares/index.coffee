methodOverride = require 'method-override'
cookieParser   = require 'cookie-parser'
bodyParser     = require 'body-parser'
mongoose       = require 'mongoose'
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

  Menu = mongoose.model 'Menu'

  app.use (req, res, next)->
    if !app.get('menu')
      Menu.find({}).exec((err, menu)->
        if err
          gebug err
          throw err
        unless menu.length
          main    = new Menu {title:'Главная', href: '/'}
          remont  = new Menu {title:'Ремонт',  href: '/remont/'}
          post    = new Menu {title:'Статьи',  href: '/posts/'}
          gallary = new Menu {title:'Галерея', href: '/gallery/'}
          price   = new Menu {title:'Цены',    href: '/price/'}

          main.save ()->remont.save ()->post.save ()->gallary.save ()->price.save ()->
          menu = [main, remont, post, gallary, price]
        app.set 'menu', menu
        next()
      )
    else
      next()