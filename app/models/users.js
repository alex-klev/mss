var Schema, User, crypto, mongoose;

mongoose = require('mongoose');

Schema = mongoose.Schema;

crypto = require('crypto');

User = new Schema({
  hPassword: {
    type: String,
    "default": ''
  },
  login: {
    type: String,
    "default": ''
  },
  salt: {
    type: String,
    "default": ''
  },
  rules: []
});

User.virtual('password').set(function(password) {
  this._password = password;
  this.salt = this.makeSalt();
  return this.hPassword = this.encryptPassword(password);
}).get(function() {
  return this._password;
});

User.path('login').validate(function(login) {
  return login.length > 4;
}, 'Login должен содержать пять и более символов');

User.path('hPassword').validate(function(hPassword) {
  return hPassword.length;
}, 'Password не может быть пустым');

User.methods = {
  authenticate: function(plainText) {
    return this.encryptPassword(plainText) === this.hPassword;
  },
  makeSalt: function() {
    return Math.round(new Date().valueOf() * Math.random()) + '';
  },
  encryptPassword: function(password) {
    var err;
    if (!password) {
      return '';
    }
    try {
      return crypto.createHmac('sha1', this.salt).update(password).digest('hex');
    } catch (_error) {
      err = _error;
      return '';
    }
  }
};

mongoose.model('User', User);
