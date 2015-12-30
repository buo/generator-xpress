mongoose = require 'mongoose'
Schema = mongoose.Schema

EntrySchema = new Schema
  title: String
  link: String
  content: String
  updated: {
    type: Date
    default: Date.now
  }
,
  versionKey: false

EntrySchema.virtual('date').get ->
  moment(@updated).format('YYYY-MM-DD')

EntrySchema.statics.all = ->
  this.find().sort({_id: -1})

mongoose.model 'Entry', EntrySchema
