var administrator, posts, statics;

administrator = require('./administrator');

statics = require('./statics');

posts = require('./posts');

module.exports = function(app) {
  app.use('/', statics);
  app.use('/posts', posts);
  app.use('/admin', administrator);
};
