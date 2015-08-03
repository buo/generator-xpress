var generators = require('yeoman-generator');
var glob = require('glob');
var mkdirp = require('mkdirp');
var path = require('path');
var slugify = require('underscore.string/slugify');

module.exports = generators.Base.extend({
  constructor: function () {
    generators.Base.apply(this, arguments);

    this.slugify = slugify;
  },
  setup: function () {
    this.sourceRoot(path.join(__dirname, 'templates'));
    glob.sync('**', { cwd: this.sourceRoot() }).map(function (file) {
      this.template(file, file.replace(/^_/, ''));
    }, this);
  },
  install: function () {
    this.installDependencies();
  }
});
