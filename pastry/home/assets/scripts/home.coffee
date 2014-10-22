require 'purecss/pure.css'

$ = require 'jquery'
content = require 'home/lib/content'

$ ->
  $('body').html(content).fadeOut 'slow', ->
    $(this).fadeIn()
