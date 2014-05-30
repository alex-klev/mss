cookieParser = require 'cookie-parser'
bodyParser   = require 'body-parser'
mongoose     = require 'mongoose'
favicon      = require 'static-favicon'
express      = require 'express'
logger       = require 'morgan'
path         = require 'path'
debug        = require('debug')('app')

routes = require './controllers/index'
users  = require './controllers/users'

app = express()

app.set 'views', path.join(__dirname, './../views/template')
app.set 'view engine', 'jade'
app.use favicon()
app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookieParser()
app.use express.static(path.join(__dirname, './../public'))

connect = ()->
  options = {server: {socketOptions: {keepAlive: 1}}}
  mongoose.connect 'mongodb://localhost/mss', options
connect()
mongoose.connection.on 'error', (err)-> debug err
mongoose.connection.on 'disconnected', ()-> connect()

require('./models/menu')();
Menu = mongoose.model 'Menu'
app.use (req, res, next)->
  console.log app.get('menu')
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

app.use '/', routes
app.use '/users', users

#/ catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next err
  return


#/ error handlers

# development error handler
# will print stacktrace
if app.get('env') is 'development'
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render 'errors/error',
      message: err.message
      error: err

    return


# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render 'errors/error',
    message: err.message
    error: {}

  return

module.exports = app