express = require 'express'
config = require './config/config'
glob = require 'glob'
mongoose = require 'mongoose'

mongoose.connect config.db
db = mongoose.connection
db.on 'error', ->
  throw new Error('unable to connect to database at ' + config.db)

models = glob.sync "#{config.root}/dist/models/*.js"
models.forEach (model) ->
  require model

app = express()
require('./config/express')(app, config)

app.listen config.port, ->
  console.log "Express server listening on port #{config.port}"
