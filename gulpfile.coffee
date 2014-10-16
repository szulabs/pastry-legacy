gulp = require 'gulp'
clean = require 'gulp-clean'
rename = require 'gulp-rename'
webpack = require 'gulp-webpack'
named = require 'vinyl-named'

# config
project =
  name: 'pastry'
  dest: 'pastry/static/pastry'
  webpack: require('./webpack.config')
assets =
  name: 'assets'
  dirs: ['scripts', 'stylesheets']
  exts: ['js', 'coffee', 'css', 'styl']
scripts =
  name: 'scripts'
  exts: ['js', 'coffee']

# alias
gulp.task 'default', ['clean', 'build']
gulp.task 'build', ['webpack']
gulp.task 'watch', ['webpack:watch']
gulp.task 'clean', ['collect:clean', 'webpack:clean']

gulp.task 'collect', ->
  dirs = assets.dirs.join(',')
  exts = assets.exts.join(',')
  gulp.src "#{project.name}/*/#{assets.name}/{#{dirs}}/**/*.{#{exts}}"
      .pipe rename((path) ->
        dirs = assets.dirs.join('|')
        pattern = new RegExp("([^/]+)/#{assets.name}/(#{dirs})(/[^/]+)?")
        matched = pattern.exec(path.dirname)
        path.dirname = "#{matched[2]}/#{matched[1]}#{matched[3] || ''}"
        path)
    .pipe clean()
    .pipe gulp.dest('build/assets')

gulp.task 'collect:clean', ->
  gulp.src "build/**/*.{#{assets.exts.join(',')}}"
      .pipe clean(force: true)

gulp.task 'webpack', ['collect'], ->
  gulp.src "build/assets/#{scripts.name}/*/*.{#{scripts.exts.join(',')}}"
      .pipe named()
      .pipe webpack(project.webpack)
      .pipe gulp.dest(project.dest)

gulp.task 'webpack:clean', ->
  gulp.src "#{project.dest}/**/*.{#{assets.exts.join(',')}}"
      .pipe clean()

gulp.task 'webpack:watch', ['webpack'], ->
  dirs = assets.dirs.join(',')
  exts = assets.exts.join(',')
  location = "#{project.name}/*/#{assets.name}/{#{dirs}}/**/*.{#{exts}}"
  gulp.watch [location], ['webpack']
