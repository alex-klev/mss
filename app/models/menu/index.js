var Schema, mongoose;

mongoose = require('mongoose');

Schema = mongoose.Schema;

module.exports = function() {
  var Menu;
  Menu = new Schema({
    title: {
      type: String
    },
    href: {
      type: String
    },
    order: {
      type: Number,
      "default": 0
    },
    child: [
      {
        title: {
          type: String
        },
        href: {
          type: String
        }
      }
    ]
  });
  return mongoose.model('Menu', Menu);
};

/*
//# sourceMappingURL=index.js.map
*/
