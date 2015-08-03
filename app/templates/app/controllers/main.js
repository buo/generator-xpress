var express = require('express');
var router = express.Router();
var mongoose = require('mongoose');
var Entry = mongoose.model('Entry');

module.exports = function (app) {
  app.use('/', router);
};

router.get('/', function (req, res, next) {
  Entry.find(function (err, entries) {
    if (err) return next(err);
    res.render('index', {
      entries: entries
    });
  });
});
