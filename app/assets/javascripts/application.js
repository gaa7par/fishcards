//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function() {
  $("#switch").click(function() {
    $("#list").toggle();
  });
});
