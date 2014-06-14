var gulp    = require('gulp');
var gutil   = require('gulp-util');
var coffee  = require('gulp-coffee');
var less    = require('gulp-less');
var path    = require('path');

var paths = {
  coffee   : ['./src/coffee/**/*.coffee'],
  less     : ['./src/less/style.less'       ],
  publicjs : ['./src/coffee-cli/**/*.coffee']
};

gulp.task('default', ['coffee', 'less', 'publicjs', 'watch']);

gulp.task('coffee', function() {
  return gulp.src(paths.coffee)
    .pipe(coffee({bare: true, sourceMap: false}).on('error', gutil.log))
    .pipe(gulp.dest('./app'))
});

gulp.task('less', function () {
  return gulp.src(paths.less)
    .pipe(less({paths: [path.join(__dirname, 'less', 'includes')], compress: false}).on('error', gutil.log))
    .pipe(gulp.dest('./public/css'));
});

gulp.task('publicjs', function() {
  return gulp.src(paths.publicjs)
    .pipe(coffee({bare: false, sourceMap: true}).on('error', gutil.log))
    .pipe(gulp.dest('./public/js'))
});

gulp.task('watch', function() {
  gulp.watch(paths.coffee, ['coffee']);
  gulp.watch('./src/less/**/*.less', ['less']);
  gulp.watch(paths.publicjs, ['publicjs']);
});

gulp.task('build', ['coffee', 'less', 'publicjs']);