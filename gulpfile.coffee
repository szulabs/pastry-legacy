gulp = require 'gulp'
rename = require 'gulp-rename'
webpack = require 'gulp-webpack'
stylus = require 'gulp-stylus'
named = require 'vinyl-named'
del = require 'del'
path = require 'path'
nib = require 'nib'
browserSync = require 'browser-sync'
{argv} = require 'yargs'

# config

project =
  name: 'pastry'
  dest: 'pastry/static'
  build: 'build/assets'
  webpack: require('./webpack.config')
scripts =
  name: 'scripts'
  exts: ['js', 'coffee']
stylesheets =
  name: 'stylesheets'
  exts: ['css', 'styl']
assets =
  name: 'assets'
  dirs: [scripts.name, stylesheets.name]
  exts: [].concat(scripts.exts, stylesheets.exts)
  glob: (bundle) ->
    if bundle
      "#{project.build}/#{bundle.name}/*/*.{#{bundle.exts.join(',')}}"
    else
      dirs = assets.dirs.join(',')
      exts = assets.exts.join(',')
      "#{project.name}/*/#{assets.name}/{#{dirs}}/**/*.{#{exts}}"

# tasks

gulp.task 'default', ['clean'], ->
  gulp.start 'build'

gulp.task 'build', ['webpack', 'style']

gulp.task 'clean', ['clean:collect', 'clean:dist']

gulp.task 'watch', ['default'], ->
  gulp.start 'browser-sync'
  gulp.watch assets.glob(), ['build']

gulp.task 'collect', ->
  gulp.src assets.glob()
      .pipe rename((path) ->
        dirs = assets.dirs.join('|')
        pattern = new RegExp("([^/]+)/#{assets.name}/(#{dirs})(/[^/]+)?")
        matched = pattern.exec(path.dirname)
        path.dirname = "#{matched[2]}/#{matched[1]}#{matched[3] || ''}"
        path)
      .pipe gulp.dest(project.build)

gulp.task 'webpack', ['collect'], ->
  gulp.src assets.glob(scripts)
      .pipe named((file) ->
        dirname = path.basename(path.dirname(file.path))
        filename = path.basename(file.path, path.extname(file.path))
        path.join(dirname, filename))
      .pipe webpack(project.webpack)
      .pipe gulp.dest("#{project.dest}/#{scripts.name}")

gulp.task 'style', ['collect'], ->
  options =
    use: [nib()]
    compress: not argv.debug
    sourcemap: { inline: argv.debug } if argv.debug
  gulp.src assets.glob(stylesheets)
      .pipe stylus(options)
      .pipe gulp.dest("#{project.dest}/#{stylesheets.name}")
      .pipe browserSync.reload(stream: true)

gulp.task 'browser-sync', ->
  port = argv.port or process.env.PORT
  proxy = argv.proxy or "localhost:#{port - 100}"
  browserSync port: port, proxy: proxy, open: false

gulp.task 'clean:collect', (done) ->
  del [
    "#{project.build}/**/*.{#{assets.exts.join(',')}}"
  ], done

gulp.task 'clean:dist', (done) ->
  del [
    "#{project.dest}/**/*",
  ], done
