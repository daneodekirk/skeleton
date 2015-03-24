module.exports = (grunt) ->

  grunt.initConfig

    pkg : grunt.file.readJSON 'package.json'

    concat :
      dist :
        src : ['js/*']
        dest : 'app.js'

    jshint :
      files : [ '<%= concat.dist.src %>']
      options :
        asi: true,
        smarttabs: true,
        laxcomma: true,
        lastsemic: true,
        globals:
          jQuery: true,
          console: true,
          module: true,
          document: true

    uglify:
      options:
        banner: '/*! <%= pkg.name %> <%= grunt.template.today() %> */\n'
        sourceMap: true
        sourceMapIncludeSources: true
        # sourceMapIn: 'js/boundless.js.map'

      dist:
        files:
          'app.js': '<%= concat.dist.dest %>'

    less :
      app:
        options:
          compress: true
          sourceMap: true
          sourceMapFilename: 'app.css.map'
          sourceMapURL: 'app.css.map'

        files :
          'app.css' : 'less/app.less'

    jade:
      options :
        pretty: false
      compile:
        files:
          "index.html": [ "jade/index.jade" ]

    notify:
      watch:
        options:
          title: 'Done',
          message: '<%= pkg.name %> built successfully.'

    watch :
      config :
        files : [ 'gruntfile.coffee' ]
        options :
          reload : true
      js :
        files: ['<%= concat.dist.src %>']
        tasks: ['default']
      css:
        files: [ 'less/*.less' ]
        tasks: ['default' ]
      jade :
        files: [ 'jade/*.jade', 'jade/*/*.jade' ]
        tasks: ['default' ]


  grunt.loadNpmTasks 'grunt-notify'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jade'

  grunt.registerTask 'default', [ 'jshint', 'concat', 'uglify', 'less', 'jade', 'notify'  ]




