express = require 'express'
router  = express.Router()

StaticsController = require './statics'

router.get '/', StaticsController.get.index
router.get '/landing', StaticsController.get.landing
router.get '/remont', StaticsController.get.remont
router.get '/materialy', StaticsController.get.materialy
router.get '/gallery', StaticsController.get.gallery
router.get '/price', StaticsController.get.price
router.route '/login'
  .get StaticsController.get.login
#  .post StaticsController.post.login

module.exports = router