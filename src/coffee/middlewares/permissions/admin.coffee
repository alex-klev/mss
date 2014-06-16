module.exports = (req, res, next)->
  console.log 'middleware admin permissions'
  next()