require 'purecss/pure.css'
require 'home/home.styl'

$ = require 'jquery'
content = require 'home/lib/content'

$ ->
  $('body').html(content).fadeOut 'slow', ->
    $(this).fadeIn()
