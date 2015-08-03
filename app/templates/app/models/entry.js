var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var EntrySchema = new Schema({
  title: String,
  url: String,
  text: String
});

EntrySchema.virtual('date').get(function(){
  return this._id.getTimestamp();
});

mongoose.model('Entry', EntrySchema);
