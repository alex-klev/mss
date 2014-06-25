winston = require 'winston'
require('winston-mongodb').MongoDB
longPoll = require './../controllers/administrator/longpolling'

getLogger = (module)->
  path = module.filename.split('/').slice(-2).join('/')

  info = new winston.Logger
    transports: [
      new winston.transports.Console
        timestamp  : true
        colorize   : true
        label      : path
        level      : 'info'
      new winston.transports.MongoDB
        cappedSize : 10000000
        capped     : true
        collection : 'infolog'
        db         : 'mss'
        level      : 'info'
    ]

  error = new winston.Logger
    transports: [
      new winston.transports.Console
        timestamp  : true
        colorize   : true
        label      : path
        level      : 'error'
      new winston.transports.MongoDB
        cappedSize : 10000000
        capped     : true
        collection : 'errlog'
        db         : 'mss'
        level      : 'error'
    ]

  error.stream(start: -1).on 'log', (log)->
    longPoll.publish log if longPoll.len


  return logger =

    info: (msg)->
      info.info msg
      return

    error: (msg)->
      error.error msg
      return

    query:
      info: (options, callback)->
        info.query options, callback
        return
      error: (options, callback)->
        error.query options, callback
        return

module.exports = getLogger