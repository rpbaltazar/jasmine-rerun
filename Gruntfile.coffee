# Generated on 2014-08-08 using generator-chrome-extension 0.2.9
"use strict"

# # Globbing
# for performance reasons we're only matching one level down:
# 'test/spec/{,*/}*.js'
# use this if you want to recursively match all subfolders:
# 'test/spec/**/*.js'
module.exports = (grunt) ->

  # Load grunt tasks automatically
  require("load-grunt-tasks") grunt

  # Time how long tasks take. Can help when optimizing build times
  require("time-grunt") grunt

  # Configurable paths
  config =
    app: "app"
    dist: "dist"

  grunt.initConfig

    # Project settings
    config: config
    manifest: grunt.file.readJSON('app/manifest.json')

    # Empties folders to start fresh
    clean:
      chrome: {}
      dist:
        files: [
          dot: true
          src: [
            "<%= config.dist %>/*"
            "!<%= config.dist %>/.git*"
          ]
        ]

    # Compiles CoffeeScript to JavaScript
    coffee:
      dist:
        files: [
          expand: true
          cwd: "<%= config.app %>/scripts"
          src: "{,*/}*.{coffee,litcoffee,coffee.md}"
          dest: "<%= config.app %>/scripts"
          ext: ".js"
        ]

    # The following *-min tasks produce minifies files in the dist folder
    imagemin:
      dist:
        files: [
          expand: true
          cwd: "<%= config.app %>/images"
          src: "{,*/}*.{gif,jpeg,jpg,png}"
          dest: "<%= config.dist %>/images"
        ]

    # By default, your `index.html`'s <!-- Usemin block --> will take care of
    # minification. These next options are pre-configured if you do not wish
    # to use the Usemin blocks.
    uglify:
      options:
        compress:
          drop_console: true

      dist:
        files:
          "<%= config.dist %>/scripts/*.js": ["<%= config.dist %>/scripts/*.js"]

    concat:
      dist: {}

    # Copies remaining files to places other tasks can use
    copy:
      dist:
        files: [
          expand: true
          dot: true
          cwd: "<%= config.app %>"
          dest: "<%= config.dist %>"
          src: [
            "*.png"
            "scripts/background.js"
            "scripts/content.js"
          ]
        ]

    # Run some tasks in parallel to speed up build process
    concurrent:
      dist: [
        "coffee:dist"
        "imagemin"
      ]

    # Auto buildnumber, exclude debug files. smart builds that event pages
    chromeManifest:
      dist:
        options:
          buildnumber: true
          content_scripts: [
            matches: ["http://*/*"]
            js: ["scripts/content.js"]
          ]
          background:
            target: "scripts/background.js"
            exclude: ["scripts/chromereload.js"]

        src: "<%= config.app %>"
        dest: "<%= config.dist %>"

    # Compres dist files to package
    compress:
      dist:
        options:
          archive: "package/<%=manifest.pkg_name%>-<%=manifest.version%>.zip"

        files: [
          expand: true
          cwd: "dist/"
          src: ["**"]
          dest: ""
        ]

    # commit a git-tag whenever there is a release
    gittag:
      release:
        options:
          tag: "release-<%=manifest.version%>"
          message: "New version (<%=manifest.version%>) released"

  grunt.registerTask "build", [
    "clean:dist"
    "concurrent:dist"
    "copy"
  ]

  grunt.registerTask "release", [
    "build"
    "chromeManifest:dist"
    "compress"
    "gittag"
  ]

  grunt.registerTask "default", [
    "build"
  ]
  return
