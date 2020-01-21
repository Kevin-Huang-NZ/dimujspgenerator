const {
  src,
  dest,
  pipe,
  series,
  parallel
} = require('gulp');
const del = require('delete');
const fileinclude = require('gulp-file-include');

// Define paths
const paths = {
  base: {
    base: {
      dir: './'
    },
    node: {
      dir: 'node_modules'
    },
    packageLock: {
      files: 'package-lock.json'
    }
  },
  dist: {
    html: {
      dir: 'dist',
      files: 'dist/**/*.html'
    }
  },
  src: {
    html: {
      dir: 'src',
      files: ['src/**/*.html','!src/partials/*.html']
    }
  }
};

function clean(cb) {
  del(paths.dist.html.files, cb);
}

function cleanSrc(cb) {
  del(paths.src.html.files, cb);
}

function html(cb) {
  src(paths.src.html.files)
    .pipe(fileinclude({
      prefix: '@@',
      basepath: '@file',
      indent: false
    }))
    .pipe(dest(paths.dist.html.dir));
  cb();
}

exports.cleanSrc = cleanSrc;
exports.default = series(clean, html);
