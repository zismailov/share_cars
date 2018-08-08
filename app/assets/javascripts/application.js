// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require bootstrap-sprockets
//= require activestorage
//= require turbolinks
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es.js
//= require jquery-ui/autocomplete
//= require_self


$(function () {

  $('.datepicker').datepicker({
    language: 'en'
  })

  $("#search_from, #search_to").autocomplete({
    source: function (request, response) {
      $.getJSON("/geocodes/autocomplete?term=" + request.term, function (data) {
        response($.map(data, function (el) {
          return {
            label: el.display_name,
            value: el.display_name,
            id: [el.lat, el.lon]
          }
        }))
      })
    },
    minLength: 2,
    select: function (event, ui) {
      console.log("Selected: " + ui.item.label + " aka " + ui.item.id)
      $('#search_from_coordinates').val(ui.item.id)
    }
  })

})
