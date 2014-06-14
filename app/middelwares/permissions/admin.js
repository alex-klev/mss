module.exports = function(req, res, next) {
  console.log('middleware admin permissions');
  return next();
};
