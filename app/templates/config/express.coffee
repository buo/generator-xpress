express = require 'express'
glob = require 'glob'
favicon = require 'serve-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
compress = require 'compression'
methodOverride = require 'method-override'

module.exports = (app, config) ->
  env = process.env.NODE_ENV or 'development'
  app.locals.ENV = env
  app.locals.ENV_DEVELOPMENT = env == 'development'
  app.set 'views', "#{config.root}/app/views"
  app.set 'view engine', 'jade'
  app.disable 'x-powered-by'

  # app.use(favicon(config.root + '/public/img/favicon.ico'));
  app.use logger('dev')
  app.use bodyParser.json()
  app.use bodyParser.urlencoded(extended: true)
  app.use cookieParser()
  app.use compress()
  app.use express.static "#{config.root}/public"
  app.use methodOverride()

  controllers = glob.sync "#{config.root}/dist/controllers/*.js"
  controllers.forEach (controller) ->
    require(controller)(app)

  app.use (req, res, next) ->
    err = new Error 'Not Found'
    err.status = 404
    next err

  if app.get('env') == 'development'
    app.use (err, req, res, next) ->
      res.status err.status or 500
      res.render 'error',
        message: err.message
        error: err

  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render 'error',
      message: err.message
      error: {}
