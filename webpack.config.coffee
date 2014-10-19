webpack = require 'webpack'
ExtractTextPlugin = require 'extract-text-webpack-plugin'
{extract} = require 'extract-text-webpack-plugin'
{argv} = require 'yargs'

loaders = [
  {
    test: /\.coffee$/,
    loader: 'coffee-loader'
  },
  {
    test: /\.css$/,
    loader: extract('style-loader', 'css-loader')
  },
  {
    test: /\.styl$/,
    loader: extract('style-loader', 'css-loader', 'stylus-loader')
  },
]

plugins = [
    new webpack.optimize.CommonsChunkPlugin('commons', 'commons.js'),
    new ExtractTextPlugin('[name].css'),
]

if not argv.debug
  plugins = plugins.concat [
    new webpack.optimize.UglifyJsPlugin(),
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
  plugins: plugins
  devtool: '#source-map' if argv.debug
