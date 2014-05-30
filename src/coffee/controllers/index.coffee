mongoose = require 'mongoose'
express  = require 'express'
router   = express.Router()

router.get '/', (req, res)->
  res.render 'users/index', { title: 'Express' }

module.exports = router