webpack = require 'webpack'
nib = require 'nib'
{argv} = require 'yargs'

loaders = [
  { test: /\.coffee$/, loader: 'coffee' },
  { test: /\.css$/, loader: 'style!css' },
  { test: /\.styl$/, loader: 'style!css!stylus'},
]

plugins = [
    new webpack.optimize.CommonsChunkPlugin('commons.js'),
    new webpack.optimize.UglifyJsPlugin() unless argv.debug,
]

module.exports =
  resolve:
    extensions: ['', '.js', '.coffee']
    modulesDirectories: [
      'node_modules',
      'scripts',
      'stylesheets',
    ]
  module:
    loaders: loaders
  plugins: plugins.filter((item) -> item)  # keep truthy items only
  devtool: 'source-map' if argv.debug
  cache: false
  stylus:
    use: [nib()]
