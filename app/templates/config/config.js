var path = require('path'),
    rootPath = path.normalize(__dirname + '/..'),
    env = process.env.NODE_ENV || 'development';

var config = {
  development: {
    root: rootPath,
    app: {
      name: '<%= slugify(appname) %>'
    },
    port: 3000,
    db: 'mongodb://localhost/<%= slugify(appname) %>'
  },

  test: {
    root: rootPath,
    app: {
      name: '<%= slugify(appname) %>'
    },
    port: 3000,
    db: 'mongodb://localhost/<%= slugify(appname) %>-test'
  },

  production: {
    root: rootPath,
    app: {
      name: '<%= slugify(appname) %>'
    },
    port: 3000,
    db: 'mongodb://localhost/<%= slugify(appname) %>'
  }
};

module.exports = config[env];
