middleware = require './middlewares'
favicon    = require 'serve-favicon'
express    = require 'express'
config     = require './config'
logger     = require 'morgan'
path       = require 'path'
log        = require('./helpers/log')(module)
sql        = require 'mssql'
fs         = require 'fs'

app = express()

config =
  user: 'sa'
  password: '12345'
  server: 'KOSTYLEVAV'
  options:
    instanceName: 'MYSQLEXPRESS'
  database: 'ReportKPP'

sql.connect config, (err)->
  if err
    log error err
  log.info 'SQL Connected'

app.set 'views', path.join(__dirname, './../../views/template')
app.set 'view engine', 'jade'
app.use favicon(path.join(__dirname + './../../public/images/favicon.png'))
app.use logger('dev')

middleware(app)

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
    err.status ?= 500
    err.msg = err.message
    err.url = req.url
    log.error err:err

    res.status err.status
    res.render 'errors/error',
      message: err.message
      error: err

    return


# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next)->
  err.status ?= 500
  err.msg = err.message
  err.url = req.url
  log.error err:err

  res.status err.status
  res.render 'errors/error',
    message: err.message
    error: {}

  return

module.exports = app