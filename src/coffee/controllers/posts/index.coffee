express = require 'express'
router  = express.Router()

PostsController = require './posts'

router.param 'chpu_id', PostsController.param.findByChpu
router.param 'page', PostsController.param.onlyDigits

router.get '/', PostsController.get.showIndex
router.get '/page:page/', PostsController.get.showIndex

router.get '/new/', PostsController.post.new
router.get '/post/:chpu_id/', PostsController.get.showId

module.exports = router