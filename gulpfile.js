var gulp       = require('gulp');
var sourcemaps = require('gulp-sourcemaps');
var coffee     = require('gulp-coffee');
var uglify     = require('gulp-uglify');
var concat     = require('gulp-concat');
var gutil      = require('gulp-util');
var less       = require('gulp-less');
var path       = require('path');

var paths = {
  coffee    : ['./src/coffee/**/*.coffee'    ],
  less      : {
    watch :   ['./src/less/**/*.less'        ],
    src   :   ['./src/less/*.less'           ]
  },
  coffeecli  : {
    pub: ['./src/coffee-cli/*.coffee'],
    a  : ['./src/coffee-cli/a/*.coffee']
  }
};

gulp.task('default', ['coffee', 'less', 'publicjs', 'adminjs', 'watch']);

gulp.task('coffee', function() {
  return gulp.src(paths.coffee)
    .pipe(coffee({bare: true, sourceMap: false}).on('error', gutil.log))
    .pipe(gulp.dest('./build/app'))
});

gulp.task('less', function () {
  return gulp.src(paths.less.src)
    .pipe(less({paths: [path.join(__dirname, 'less', 'includes')], compress: false}).on('error', gutil.log))
    .pipe(gulp.dest('./public/css'));
});

gulp.task('publicjs', function() {
  return gulp.src(paths.coffeecli.pub)
    .pipe(sourcemaps.init())
    .pipe(coffee({bare: false}).on('error', gutil.log))
    .pipe(sourcemaps.write())
    .pipe(uglify())
    .pipe(concat('script.min.js'))
    .pipe(gulp.dest('./public/js/'))
});

gulp.task('adminjs', function() {
  return gulp.src(paths.coffeecli.a)
    .pipe(sourcemaps.init())
    .pipe(coffee({bare: false}).on('error', gutil.log))
    .pipe(sourcemaps.write())
    .pipe(uglify())
    .pipe(concat('script.min.js'))
    .pipe(gulp.dest('./public/js/a/'))
});

gulp.task('watch', function() {
  gulp.watch(paths.coffee, ['coffee']);
  gulp.watch(paths.less.watch, ['less']);
  gulp.watch(paths.publicjs, ['publicjs']);
});

gulp.task('build',  ['coffee', 'less', 'publicjs', 'adminjs']);
gulp.task('public', ['less', 'publicjs', 'adminjs']);