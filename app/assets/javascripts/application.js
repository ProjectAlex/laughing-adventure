// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .
//= require websocket_rails/main
//= require owl.carousel

/*var dispatcher = new WebSocketRails('alex.ngrok.com/websocket');
dispatcher.on_open = function(data) {
  console.log('Connection has been established: ', data);
  //alert('sending');
  dispatcher.trigger('client_connected');
}
*/
/*
function addCommentToDom(comment) {
  console.log('just received new comment: ' + comment);
}
dispatcher.bind('new_post', addCommentToDom);
*/

    /*$(document).on('scroll', function() {
        if ($(window).scrollTop() >= 50) {
          $('.navbar-fixed').autoHidingNavbar('show');
        }
        else {
          $('.navbar-fixed').autoHidingNavbar('hide');
        }
      })*/
