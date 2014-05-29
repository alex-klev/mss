var gulp    = require('gulp');
var changed = require('gulp-changed');
var coffee  = require('gulp-coffee');
var less    = require('gulp-less');
var path    = require('path');

var paths = {
  coffee   : ['./src/coffee/**/*.coffee'],
  less     : ['./src/less/*.less'       ],
  publicjs : ['./public/src/**/*.coffee']
};

gulp.task('default', ['coffee', 'less', 'publicjs', 'watch']);

gulp.task('coffee', function() {
  gulp.src(paths.coffee)
    .pipe(coffee({bare: true, sourceMap: true}).on('error', function(e) {
      console.log( e)
    }))
    .pipe(gulp.dest('./app'))
});

gulp.task('less', function () {
  gulp.src(paths.less)
    .pipe(
      less({
        paths: [ path.join(__dirname, 'less', 'includes') ]
      })
        .on('error', function(e) {
          console.log(e);
        })
    )
    .pipe(gulp.dest('./public/css'));
});

gulp.task('publicjs', function() {
  gulp.src(paths.publicjs)
    .pipe(coffee({bare: false, sourceMap: true}).on('error', function(e) {
      console.log( e)
    }))
    .pipe(gulp.dest('./public/js'))
});

gulp.task('watch', function() {
  gulp.watch(paths.coffee, ['coffee']);
  gulp.watch(paths.less, ['less']);
  gulp.watch(paths.publicjs, ['publicjs']);
});