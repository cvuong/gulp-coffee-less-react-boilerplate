concat    = require 'gulp-concat'
coffeeify = require 'gulp-coffeeify'
gulp      = require 'gulp'
less      = require 'gulp-less'

gulp.task 'default', [
  'bower'
  'coffee'
  'html'
  'less'
  'server'
  'watch'
]

# The 'bower' task moves all of the 3rd party components in inside of
# 'bower_components' to 'dist/js/3rd.js'
gulp.task 'bower', ->
  gulp.src([
    './bower_components/react/react.min.js'
  ])
    .pipe(concat('3rd.js'))
    .pipe(gulp.dest('./dist/js'))
  return

# The 'coffee' task watches and compiles all of the .coffee files inside of
# 'src/coffee' to 'dist/js'
gulp.task 'coffee', ->
  gulp.src('./src/coffee/**/*.coffee')
    .pipe(coffeeify())
    .pipe(gulp.dest('./dist/js'))
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
    .pipe(less())
    .pipe(gulp.dest('./dist/css'))
  return

# The 'server' task starts a server and serves the static assets in 'dist'
gulp.task 'server', ->
  return

# The 'watch' task watches the bower, coffee, html, less files for changes
# and runs their tasks again.
gulp.task 'watch', ->
  gulp.watch('./bower_components', ['bower'])
  gulp.watch('./src/coffee/**/*.coffee', ['coffee'])
  gulp.watch('./src/html/**/*.html', ['html'])
  gulp.watch('./src/less/**/*.less', ['less'])
  return
