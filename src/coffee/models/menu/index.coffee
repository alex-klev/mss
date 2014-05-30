mongoose = require 'mongoose'
Schema   = mongoose.Schema

module.exports = ()->
  Menu = new Schema({
    title : {type: String},
    href  : {type: String},
    order : {type: Number, default: 0},
    child : [{
      title : {type: String},
      href  : {type: String}
    }]
  })

  mongoose.model 'Menu', Menu