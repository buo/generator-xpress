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

  openshift: {
    root: rootPath,
    app: {
      name: '<%= slugify(appname) %>'
    },
    ipaddress: process.env.OPENSHIFT_NODEJS_IP,
    port: process.env.OPENSHIFT_NODEJS_PORT,
    db: process.env.OPENSHIFT_MONGODB_DB_URL + process.env.OPENSHIFT_GEAR_NAME
  }
};

module.exports = config[env];
