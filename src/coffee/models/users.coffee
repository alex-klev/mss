mongoose = require 'mongoose'
Schema   = mongoose.Schema
crypto   = require 'crypto'

User = new Schema
  hPassword:
    type: String
    default: ''
  login:
    type: String
    default: ''
  salt:
    type: String
    default: ''
  rules: []

User
  .virtual 'password'
  .set (password)->
    @_password = password
    @salt = @makeSalt()
    @hPassword = @encryptPassword password
  .get ()->
    return @_password

User.path 'login'
  .validate (login)->
    return login.length > 4
  , 'Login должен содержать пять и более символов'

User.path 'hPassword'
  .validate (hPassword)->
    return hPassword.length
  , 'Password не может быть пустым'

User.methods =

  authenticate: (plainText)->
    return @encryptPassword(plainText) is @hPassword

  makeSalt: ()->
    return Math.round((new Date().valueOf() * Math.random())) + ''

  encryptPassword: (password)->
    return '' if !password
    try
      return crypto.createHmac('sha1', @.salt).update(password).digest('hex')
    catch err
      return ''

mongoose.model 'User', User