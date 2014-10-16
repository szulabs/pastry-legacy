gulp = require 'gulp'
gulp.clean = require 'gulp-clean'
gulp.rename = require 'gulp-rename'
gulp.webpack = require 'gulp-webpack'
gulp.merge = require 'merge-stream'
gulp.named = require 'vinyl-named'
webpack = require 'webpack'
path = require 'path'
yargs = require 'yargs'
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

gulp.task 'webpack:build', ['collect'], ->
  gulp.src 'build/assets/scripts/*/*.{js,coffee}'
    .pipe gulp.named()
    .pipe gulp.webpack
      resolve:
        extensions: ['', '.js', '.coffee']
        modulesDirectories: [
          'node_modules',
          'scripts',
          'stylesheets',
        ]
      module:
        loaders: [
          {
            test: /\.coffee$/,
            loader: 'coffee-loader'
          },
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
      devtool: '#source-map' if yargs.argv['enable-sourcemap']
    .pipe gulp.dest('pastry/static/pastry')

gulp.task 'webpack:clean', ->
  gulp.src 'pastry/static/**/*.{js,css}'
    .pipe gulp.clean()

gulp.task 'webpack:watch', ['webpack:build'], ->
  gulp.watch ['**/assets/**/*.{js,coffee,css,styl}'], ['webpack:build']
