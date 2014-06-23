winston = require 'winston'
MongoDB = require('winston-mongodb').MongoDB


module.exports = (mod)->
  path = mod.filename.split('/').slice(-2).join('/')

  return new winston.Logger
    transports: [
      new winston.transports.Console
        timestamp : true
        colorize  : true
        level     : 'info'
        label     : path

      new winston.transports.MongoDB
        level: 'error'
        collection: 'errlog'
        db: 'mss'
    ]