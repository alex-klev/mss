mongoose = require 'mongoose'
Schema   = mongoose.Schema

Posts = new Schema({
  title : {type: String},
  html  : {type: String},
  date  : {type: Date, default: Date.now()},
  active: {type: Boolean, default: false}
})

mongoose.model 'Posts', Posts