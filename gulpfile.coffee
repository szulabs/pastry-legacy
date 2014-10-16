gulp = require 'gulp'
clean = require 'gulp-clean'
rename = require 'gulp-rename'
webpack = require 'gulp-webpack'
named = require 'vinyl-named'
merge = require 'merge-stream'

# alias
gulp.task 'default', ['build']
gulp.task 'build', ['webpack:build']
gulp.task 'watch', ['webpack:watch']
gulp.task 'clean', ['collect:clean', 'webpack:clean']

gulp.task 'collect', ->
  paths =
    scripts: '/assets/scripts'
    stylesheets: '/assets/stylesheets'
  scripts = gulp.src "pastry/*/#{paths.scripts}/**/*.{js,coffee}"
    .pipe rename((path) ->
      path.dirname = path.dirname.replace(paths.scripts, '')
      path)
    .pipe clean()
    .pipe gulp.dest('build' + paths.scripts)
  stylesheets = gulp.src("pastry/*/#{paths.stylesheets}/**/*.{css,styl}")
    .pipe rename((path) ->
      path.dirname = path.dirname.replace(paths.stylesheets, '')
      path)
    .pipe clean()
    .pipe gulp.dest('build' + paths.stylesheets)
  merge(scripts, stylesheets)

gulp.task 'collect:clean', ->
  gulp.src 'build/**/*.{js,css,coffee,styl}'
      .pipe clean(force: true)

gulp.task 'webpack:build', ['collect'], ->
  gulp.src 'build/assets/scripts/*/*.{js,coffee}'
      .pipe named()
      .pipe webpack(require('./webpack.config'))
      .pipe gulp.dest('pastry/static/pastry')

gulp.task 'webpack:clean', ->
  gulp.src 'pastry/static/**/*.{js,css}'
      .pipe clean()

gulp.task 'webpack:watch', ['webpack:build'], ->
  gulp.watch ['**/assets/**/*.{js,coffee,css,styl}'], ['webpack:build']
