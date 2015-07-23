path = require('path')
escapeChar = process.platform.match(/^win/) ? '^' : '\\'
cwd = process.cwd().replace(/( |\(|\))/g, escapeChar + '$1')

# js files to concat/minify
jsToConcat = [
  'bower_components/jquery/dist/jquery.min.js'
  '.tmp/js/*.js'
]

module.exports = (grunt) ->

  grunt.initConfig

    pkg:
      grunt.file.readJSON 'package.json'

    # grunt shell
    shell:
      bower:
        command: path.resolve(cwd + '/node_modules/.bin/bower --allow-root install')
        options:
          stdout: true,
          stdin: false

    # grunt clean
    clean: [
      '.tmp/public/**'
      'built'
    ]

    # grunt sass
    sass:
      compile:
        options:
          style: 'expanded'
        files: [
          expand: true
          cwd: 'scss'
          src: ['**/*.scss']
          dest: '.tmp/css'
          ext: '.css'
        ]

    # grunt coffee
    coffee:
      compile:
        expand: true
        cwd: 'coffee'
        src: ['**/*.coffee']
        dest: '.tmp/js'
        ext: '.js'

    # grunt concat
    concat:
      js:
        src: jsToConcat
        dest: '.tmp/concat/production.js'

    # grunt uglify
    uglify:
      complete:
        src: ['.tmp/concat/production.js']
        dest: 'dist/production.min.js'
      lite:
        src: ['.tmp/js/*.js']
        dest: 'dist/production.lite.min.js'

    # grunt cssmin
    cssmin:
      dist:
        src: ['.tmp/css/*.css']
        dest: 'dist/production.min.css'

    # grunt watch
    watch:
      scripts:
        files: ['**/*.coffee']
        tasks: ['default']
 
  # load plugins
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  # tasks
  grunt.registerTask 'default', [
    'clean'
    'shell'
    'sass'
    'coffee'
    'concat'
    'uglify'
    'cssmin'
  ]