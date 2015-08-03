var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var EntrySchema = new Schema({
  title: String,
  link: String,
  content: String
}, {
  versionKey: false
});

EntrySchema.statics.all = function all() {
  return this.find().sort({_id: -1});
}

EntrySchema.virtual('date').get(function(){
  return this._id.getTimestamp();
});

mongoose.model('Entry', EntrySchema);
