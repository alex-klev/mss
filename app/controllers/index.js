var express, mongoose, router;

mongoose = require('mongoose');

express = require('express');

router = express.Router();

router.get('/', function(req, res) {
  return res.render('users/index', {
    title: 'Express'
  });
});

module.exports = router;

/*
//# sourceMappingURL=index.js.map
*/
