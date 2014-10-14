$ = require 'jquery'
content = require './lib/content'

$ ->
  $('body').html(content).fadeOut 'slow', ->
    $(this).fadeIn()
