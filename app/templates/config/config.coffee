path = require 'path'
rootPath = path.normalize "#{__dirname}/../.."
env = process.env.NODE_ENV or 'development'

config =
  development:
    root: rootPath
    app: name: '<%= slugify(appname) %>'
    port: 8080
    db: 'mongodb://localhost/<%= slugify(appname) %>'
  test:
    root: rootPath
    app: name: '<%= slugify(appname) %>'
    port: 8080
    db: 'mongodb://localhost/<%= slugify(appname) %>-test'
  production:
    root: rootPath
    app: name: '<%= slugify(appname) %>'
    port: process.env.PORT or 8080
    # ipaddress: process.env.OPENSHIFT_NODEJS_IP,
    # port: process.env.OPENSHIFT_NODEJS_PORT,
    # db: process.env.OPENSHIFT_MONGODB_DB_URL + process.env.OPENSHIFT_GEAR_NAME
    db: process.env.MONGOLAB_URI or
        'mongodb://localhost/<%= slugify(appname) %>-production'

module.exports = config[env]
