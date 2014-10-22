gulp = require 'gulp'
rename = require 'gulp-rename'
webpack = require 'gulp-webpack'
named = require 'vinyl-named'
del = require 'del'

# config

project =
  name: 'pastry'
  dest: 'pastry/static'
  webpack: require('./webpack.config')
assets =
  name: 'assets'
  dirs: ['scripts', 'stylesheets']
  exts: ['js', 'coffee', 'css', 'styl']
  glob: ->
    dirs = assets.dirs.join(',')
    exts = assets.exts.join(',')
    "#{project.name}/*/#{assets.name}/{#{dirs}}/**/*.{#{exts}}"
scripts =
  name: 'scripts'
  exts: ['js', 'coffee']

# tasks

gulp.task 'default', ['clean'], -> gulp.start('build')

gulp.task 'build', ['webpack']

gulp.task 'clean', ['collect:clean', 'webpack:clean']

gulp.task 'watch', ['default'], ->
  gulp.watch assets.glob(), ['build']

gulp.task 'collect', ->
  gulp.src assets.glob()
      .pipe rename((path) ->
        dirs = assets.dirs.join('|')
        pattern = new RegExp("([^/]+)/#{assets.name}/(#{dirs})(/[^/]+)?")
        matched = pattern.exec(path.dirname)
        path.dirname = "#{matched[2]}/#{matched[1]}#{matched[3] || ''}"
        path)
      .pipe gulp.dest('build/assets')

gulp.task 'collect:clean', (done) ->
  del [
    "build/**/*.{#{assets.exts.join(',')}}"
  ], done

gulp.task 'webpack', ['collect'], ->
  gulp.src "build/assets/#{scripts.name}/*/*.{#{scripts.exts.join(',')}}"
      .pipe named()
      .pipe webpack(project.webpack)
      .pipe gulp.dest(project.dest)

gulp.task 'webpack:clean', (done) ->
  del [
    "#{project.dest}/**/*",
  ], done
