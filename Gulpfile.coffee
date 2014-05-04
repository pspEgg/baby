gulp = require('gulp')
sass = require('gulp-sass')
livereload = require('gulp-livereload')
watch = require('gulp-watch')
nodemon = require('gulp-nodemon')
plumber = require('gulp-plumber')
browserify = require('gulp-browserify')
rename = require('gulp-rename')
prefix = require('gulp-autoprefixer')

gulp.task 'default', () ->
  server = livereload() # Create tiny livereload server

  nodemon({
    script: 'app/app.coffee',
    ext: 'coffee',
    env: { 'NODE_ENV': 'development' , 'PORT': 5000},
    watch: ['app'],
    ignore: ["app/js/", "Gulpfile.coffee"]
  }).on 'restart', () -> console.log 'Restarted Server!'
 
  watch { glob: 'app/**/*.scss' }, () ->
    gulp.src(['app/css/reader.scss'])
      .pipe(plumber())
      .pipe(sass({
        errLogToConsole: true,
        includePaths: ['./']
        }))
      .pipe(prefix("last 1 version", "> 1%", "ie 8", "ie 7"))
      .pipe(rename({
        dirname: "css"
        }))
      .pipe(gulp.dest('./build'))
      .pipe(livereload())

  # Rebuild Client-side JS, then Livereload on /js file changes
  watch { glob: 'app/js/**/*.coffee' }, () ->
    gulp.src(['app/js/reader.coffee'], { read: false })
      .pipe(plumber())
      .pipe(browserify({
        transform: ['coffeeify'],
        extensions: ['.coffee']
      }))
      .pipe(rename({
        dirname: "js",
        extname: ".js"
        }))
      .pipe(gulp.dest('./build'))
      .pipe(livereload())

  # Livereload on .jade file change
  watch { glob: 'app/view/**/*.jade' }
    .pipe(plumber())
    .pipe(livereload())


