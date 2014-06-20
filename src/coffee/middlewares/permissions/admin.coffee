module.exports = (req, res, next)->
  if req.session.user
    return next()
  else
    req.session.error = 'Представтесь, пожалуйста!'
    return res.redirect '/login'