browserify  = require 'gulp-browserify'
concat      = require 'gulp-concat'
connect     = require 'gulp-connect'
coffeeify   = require 'gulp-coffeeify'
del         = require 'del'
gulp        = require 'gulp'
http        = require 'http'
less        = require 'gulp-less'
plumber     = require 'gulp-plumber'
rename      = require 'gulp-rename'
runSequence = require 'run-sequence'

gulp.task 'default', ->
  runSequence(
    'clean'
    ['bower', 'coffee', 'html', 'less']
    'watch'
    'server'
  )
  return

# The 'bower' task moves all of the 3rd party components in inside of
# 'bower_components' to 'dist/js/3rd.js'
gulp.task 'bower', ->
  gulp.src([
    './bower_components/jquery/dist/jquery.min.js'
    './bower_components/react/react.js'
  ])
    .pipe(concat('3rd.js'))
    .pipe(gulp.dest('./dist/js'))
  return

# The 'coffee' task compiles the 'src/coffee/app.coffee' to 'dist/js'
# We pass in `{read: false}` so gulp-browserify does not pipe the contents
# to node-browserify.
# More about the importance of using `{read: false}` can be found here:
# https://www.npmjs.com/package/gulp-browserify
gulp.task 'coffee', ->
  gulp.src('./src/coffee/app.coffee', read: false)
    .pipe(plumber())
    .pipe(browserify(
      debug: true
      transform: ['coffee-reactify']
      extensions: ['.coffee', '.cjsx']
    ))
    .pipe(rename('app.js'))
    .pipe(gulp.dest('./dist/js'))
  return

# The 'clean' task cleans the 'dist' folder
gulp.task 'clean', (cb) ->
  del([
    'dist'
  ], ->
    cb(null)
  )
  return

# The 'html' task watches and moves the html files inside of 'src/html'
# to 'dist'
gulp.task 'html', ->
  gulp.src('./src/html/**/*.html')
    .pipe(gulp.dest('./dist'))
  return

# The 'less' task watches and compiles the .less files inside of 'src/less'
# to 'dist/css'
gulp.task 'less', ->
  gulp.src('./src/less/**/*.less')
    .pipe(plumber())
    .pipe(less())
    .pipe(gulp.dest('./dist/css'))
  return

# The 'server' task starts a server and serves the static assets in 'dist'
gulp.task 'server', ->
  PORT = 8090
  connect.server(
    livereload: true
    port: PORT
    root: 'dist'
  )
  return

# The 'watch' task watches the coffee, cjsx, html, less files for changes
# and runs their tasks again.
gulp.task 'watch', ->
  gulp.watch('./src/coffee/**/*.coffee', ['coffee'])
  gulp.watch('./src/cjsx/**/*.cjsx', ['coffee'])
  gulp.watch('./src/html/**/*.html', ['html'])
  gulp.watch('./src/less/**/*.less', ['less'])
  return
