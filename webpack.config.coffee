yargs = require 'yargs'
webpack = require 'webpack'
ExtractTextPlugin = require 'extract-text-webpack-plugin'
extract = ExtractTextPlugin.extract

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
  devtool: '#source-map' if yargs.argv['dev']
