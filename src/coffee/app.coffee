middleware = require './middlewares'
mongoose   = require 'mongoose'
favicon    = require 'serve-favicon'
express    = require 'express'
config     = require './config'
logger     = require 'morgan'
path       = require 'path'
log        = require('./helpers/log')(module)
fs         = require 'fs'

app = express()

connect = ()->
  options = {server: {socketOptions: {keepAlive: 1}}}
  mongoose.connect 'mongodb://localhost/mss', options
connect()
mongoose.connection.on 'error', (err)-> log.error err
mongoose.connection.on 'disconnected', -> connect()

# Bootstrap models
modelsPath = path.join(__dirname, './models')
fs.readdirSync(modelsPath).forEach (file)->
  if config.get 'COFFEE'
    require(modelsPath + '/' + file) if ~file.indexOf '.coffee'
  else
    require(modelsPath + '/' + file) if ~file.indexOf '.js'

app.set 'views', path.join(__dirname, './../../views/template')
app.set 'view engine', 'jade'
app.use favicon(path.join(__dirname + './../../public/images/favicon.png'))
app.use logger('dev')

middleware(app);

# Bootstrap routes
require('./controllers') app

#/ catch 404 and forward to error handler
app.use (req, res, next)->
  err = new Error('Not Found')
  err.status = 404
  next err
  return


#/ error handlers

# development error handler
# will print stacktrace
if app.get('env') is 'development'
  app.use (err, req, res, next)->
    res.status err.status or 500
    log.error err:err, url:req.url
    res.render 'errors/error',
      message: err.message
      error: err

    return


# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next)->
  res.status err.status or 500
  log.error err:err, url:req.url
  res.render 'errors/error',
    message: err.message
    error: {}

  return

module.exports = app