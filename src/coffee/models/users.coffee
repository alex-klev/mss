mongoose = require 'mongoose'
Schema   = mongoose.Schema

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

User.path('login').validate (login)->
  return login.length > 5
, 'Login должен содержать более пяти символов'