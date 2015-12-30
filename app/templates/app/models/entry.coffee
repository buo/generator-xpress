mongoose = require 'mongoose'
Schema = mongoose.Schema

EntrySchema = new Schema
  title: String
  link: String
  content: String
,
  versionKey: false

EntrySchema.virtual('date').get ->
  @_id.getTimestamp()

EntrySchema.statics.all = ->
  this.find().sort({_id: -1})

mongoose.model 'Article', EntrySchema
