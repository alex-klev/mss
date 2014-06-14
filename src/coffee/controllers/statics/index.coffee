express = require('express')
router  = express.Router()

StaticsController = require('./statics')

router.get '/', StaticsController.get.showIndex

module.exports = router