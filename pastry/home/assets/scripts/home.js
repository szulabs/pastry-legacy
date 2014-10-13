var $ = require('jquery');
var content = require('./lib/content');

$(function() {
  $('body').html(content).fadeOut('slow', function() {
    $(this).fadeIn();
  });
});
