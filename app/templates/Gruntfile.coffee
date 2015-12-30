request = require 'request'

module.exports = (grunt) ->
  # show elapsed time at the end
  require('time-grunt')(grunt)

  # load all grunt tasks
  require('load-grunt-tasks')(grunt)

  reloadPort = 35729
  files = undefined
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    develop:
      server:
        file: 'dist/app.js'
    coffee:
      compile:
        options:
          bare: true
        files: [
          'dist/app.js': 'app.coffee'
          {
            expand: true
            cwd: 'config/'
            src: ['**/*.coffee']
            dest: 'dist/config/'
            ext: '.js'
          }
          {
            expand: true
            cwd: 'app/'
            src: ['**/*.coffee']
            dest: 'dist/'
            ext: '.js'
          }
        ]
    sass:
      dist:
        options:
          style: 'compressed'
        files:
          'public/css/style.css': 'public/css/style.scss'
    watch:
      options:
        nospawn: true
        livereload: reloadPort
      coffee:
        files: [
          'app.coffee'
          'app/**/*.coffee'
          'config/*.coffee'
        ]
        tasks: [
          'coffee'
          'develop'
          'delayed-livereload'
        ]
      css:
        files: [ 'public/css/*.scss' ]
        tasks: [ 'sass' ]
        options:
          livereload: reloadPort
      views:
        files: [
          'app/views/*.jade'
          'app/views/**/*.jade'
        ]
        options:
          livereload: reloadPort

  grunt.config.requires 'watch.coffee.files'
  files = grunt.config 'watch.coffee.files'
  files = grunt.file.expand files

  description = 'Live reload after the node server has restarted.'
  grunt.registerTask 'delayed-livereload', description, ->
    done = @async()
    setTimeout (->
      url = "http://localhost:#{reloadPort}/changed?files=#{files.join(',')}"
      request.get url, (err, res) ->
        reloaded = !err and res.statusCode == 200
        if reloaded
          grunt.log.ok 'Delayed live reload successful.'
        else
          grunt.log.error 'Unable to make a delayed live reload.'
        done reloaded
    ), 500

  grunt.registerTask 'compile', [
    'coffee'
    'sass'
  ]

  grunt.registerTask 'default', [
    'coffee'
    'sass'
    'develop'
    'watch'
  ]
