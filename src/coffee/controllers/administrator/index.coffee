express = require('express')
router  = express.Router()

adminPermissions = require '../../middlewares/permissions/admin'

AdminController = require './administrator'

router.route '*'
  .all adminPermissions

router.get '/', AdminController.showIndex

router.param 'id', AdminController.param.id
router.get '/posts', AdminController.Posts.all
router.route '/posts/new'
  .get AdminController.Posts.show
  .post AdminController.Posts.create
router.route '/posts/:id'
  .get AdminController.Posts.show
  .put AdminController.Posts.update
  .delete AdminController.Posts.delete



module.exports = router