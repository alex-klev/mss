express = require('express')
router  = express.Router()

StaticsController = require('./statics')

router.get '/', StaticsController.get.index
router.get '/remont', StaticsController.get.remont
router.get '/materialy', StaticsController.get.materialy
router.get '/gallery', StaticsController.get.gallery
router.get '/price', StaticsController.get.price
router.get '/login', StaticsController.get.login

module.exports = router