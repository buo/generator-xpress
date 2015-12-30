express = require 'express'
mongoose = require 'mongoose'
Router = express.Router()
Entry = mongoose.model 'Entry'

module.exports = (app) ->
  app.use '/', Router

Router.get '/', (req, res, next) ->
  Entry.all().limit(10).exec (err, entries) ->
    return next(err) if err
    res.render 'index', entries: entries
