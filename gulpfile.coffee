gulp = require 'gulp'
gulp.clean = require 'gulp-clean'
gulp.rename = require 'gulp-rename'
gulp.webpack = require 'gulp-webpack'
gulp.coffee = require 'gulp-coffee'
gulp.merge = require 'merge-stream'
webpack = require 'webpack'
path = require 'path'
ExtractTextPlugin = require 'extract-text-webpack-plugin'

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
    .pipe gulp.rename((path) ->
      path.dirname = path.dirname.replace(paths.scripts, '')
      path)
    .pipe gulp.clean()
    .pipe gulp.dest('build' + paths.scripts)
  stylesheets = gulp.src("pastry/*/#{paths.stylesheets}/**/*.{css,styl}")
    .pipe gulp.rename((path) ->
      path.dirname = path.dirname.replace(paths.stylesheets, '')
      path)
    .pipe gulp.clean()
    .pipe gulp.dest('build' + paths.stylesheets)
  gulp.merge(scripts, stylesheets)

gulp.task 'collect:clean', ->
  gulp.src 'build/**/*.{js,css,coffee,styl}'
    .pipe gulp.clean(force: true)

gulp.task 'compile:coffee', ['collect'], ->
  gulp.src 'build/assets/scripts/**/*.coffee'
    .pipe gulp.coffee()
    .pipe gulp.dest('build/assets/scripts')

gulp.task 'webpack:build', ['collect', 'compile:coffee'], ->
  gulp.src 'build/assets/scripts/*/*.js'
    .pipe gulp.webpack
      entryName: (file) -> path.basename(file).replace(path.extname(file), '')
      output:
        filename: '[name].js'
      resolve:
        modulesDirectories: [
          'node_modules',
          'scripts',
          'stylesheets',
        ]
      module:
        loaders: [
          {
            test: /\.css$/,
            loader: ExtractTextPlugin.extract('style-loader', 'css-loader')
          },
          {
            test: /\.styl$/,
            loader: ExtractTextPlugin.extract('style-loader', 'css-loader', 'stylus-loader')
          },
        ]
      plugins: [
        new webpack.optimize.CommonsChunkPlugin('commons', 'commons.js'),
        new ExtractTextPlugin('[name].css'),
      ]
    .pipe gulp.dest('pastry/static/pastry')

gulp.task 'webpack:clean', ->
  gulp.src 'pastry/static/**/*.{js,css}'
    .pipe gulp.clean()

gulp.task 'webpack:watch', ['webpack:build'], ->
  gulp.watch ['**/assets/**/*.{js,coffee,css,styl}'], ['webpack:build']
