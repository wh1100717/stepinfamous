module.exports = (grunt) ->
    'use strict'

    require('load-grunt-tasks')(grunt)

    grunt.initConfig {
        pkg: grunt.file.readJSON 'package.json'
        banner: """

        /**
         * <%= pkg.name %>
         * Version: <%= pkg.version %>
         * Copyright 2014 - <%= grunt.template.today("yyyy") %> <%= pkg.author %>
         */
         
        """
        clean: {
            build: ['build']
            tmp: ['.tmp']
        }
        less: {
            compileCore: {
                options: {
                    strictMath: true,
                    sourceMap: true,
                    outputSourceFiles: true,
                    sourceMapURL: '<%= pkg.name %>.css.map'
                    sourceMapFilename: '.tmp/build/css/<%= pkg.name %>.css.map'
                }
                files: {
                    '.tmp/build/css/<%= pkg.name %>.css': 'src/less/<%= pkg.name %>.less'
                }
            }
        }
        cssmin: {
            options: {
                keepSpecialComments: '*'
                noAdvanced: true
            }
            core: {
                files: {
                    '.tmp/build/css/<%= pkg.name %>.css': '.tmp/build/css/<%= pkg.name %>.css'
                }
            }
        }
        usebanner: {
            dist: {
                options: {
                    position: 'top'
                    banner: '<%= banner %>'
                }
                files: {
                    src: [
                        '.tmp/build/css/<%= pkg.name %>.css'
                    ]
                }
            }
        }
        copy: {
            js: {
                expand: true
                cwd: "src/"
                src: ["js/**/*.js"]
                dest: ".tmp/build/"
            }
            module: {
                expand: true
                cwd: "src/"
                src: ["module/**/*.js"]
                dest: ".tmp/build/"
            }
            img: {
                expand: true
                cwd: "src/"
                src: ["img/**"]
                dest: ".tmp/build/"
            }
            bower: {
                expand: true
                cwd: "bower_components/"
                src: ["**/*"]
                dest: ".tmp/build/vendor/"
            }
            build: {
                expand: true
                cwd: ".tmp/build/"
                src: ["**"]
                dest: "build/"
            }
        }
        uglify: {
            options: {
                mangle: {
                    except: ['require']
                }
                normalizeDirDefines: true
                skipDirOptimize: false
                banner: '<%= banner %>'
                preserveComments: 'some'
            }
            js: {
                files: [{
                    expand: true
                    cwd: ".tmp/build/"
                    src: ["**/*.js"]
                    dest: "build/"
                }]
            }
        }
        connect: {
            options: {
                port: 9008
                livereload: 42201
                hostname: 'localhost'
                base: '.'
                middleware: (connect, options, middlewares) ->
                    middlewares.unshift (req, res, next) ->
                        req.url = "/index.html" if req.url is "/"
                        if req.url.indexOf("http://") isnt -1
                            return next()
                        if req.url.indexOf(".json") isnt -1
                            return next()
                        if req.url.indexOf(".html") isnt -1
                            req.url = "/view" + req.url
                            return next()
                        req.url = "/.tmp/build" + req.url
                        return next()
                    return middlewares
            }
            livereload: {
                options: {
                    open: {
                        target: "http://localhost:9008/index.html"
                    }
                }
            }
        }
        watch: {
            less: {
                files: 'src/less/**/*.less'
                tasks: ['less']
            }
            js: {
                files: 'src/js/**/*.js'
                tasks: ['copy:js']
            }
            img: {
                files: 'src/img/**'
                tasks: ['copy:img']
            }
            module: {
                files: 'src/module/**'
                tasks: ['copy:module']
            }
            tpl: {
                files: 'src/tpl/**/*.tpl'
                tasks: ['nunjucks']
            }
            livereload: {
                options: {
                    livereload: '<%= connect.options.livereload %>'
                }
                files: [
                    '{,*/}*.html'
                    '.tmp/build/**/css/{,*/}*.css'
                    '.tmp/build/**/js/{,*/}*.js'
                    '.tmp/build/**/module/**'
                    '.tmp/build/**/img/**'
                    '.tmp/build/**/tpl/**'
                ]
            }
        }
    }

    grunt.registerTask 'servebuild', [
        'clean:tmp'
        'copy:js'
        'copy:module'
        'copy:img'
        'copy:bower'
        'less'
    ]

    grunt.registerTask 'build', [
        'clean:*'                       #Clean .tmp && build folder
        'less', 'cssmin', 'usebanner'   #Build Css
        'copy:*'
        'uglify:js'                     #Uglify JS
    ]

    grunt.registerTask 'serve', ['servebuild', 'connect:livereload', 'watch']

    grunt.registerTask 'server', ['serve']

    grunt.registerTask 'default', ['serve']

    return
