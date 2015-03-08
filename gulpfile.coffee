gulp      = require 'gulp'
coffeeify = require 'gulp-coffeeify'

gulp.task 'default', ->
  gulp.src('src/coffee/**/*.coffee')
    .pipe(coffeeify())
    .pipe(gulp.dest('./dist/js'))
  return
