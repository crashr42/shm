#= require ./rails
#= require jquery
#= require ./ajax
#= require jquery-ui
#= require jquery_ujs
#= require twitter/bootstrap
#= require fullcalendar
#= require moment
#= require rails.validations
#= require underscore
#= require backbone
#= require backbone_rails_sync
#= require backbone_datalink
#= require_tree .

bind_datepicker = ->
  $('input.datepicker').datepicker(
    format: 'dd.mm.yyyy',
    weekStart: 1,
    todayBtn: true,
    todayHighlight: true
  ).keydown(-> return false)

bind_timepicker = -> $('input.timepicker').timepicker()

bind_file_input = ->
  $('.b_file').each ->
    i_file = $(this).prev()
    file = $(this).parent().prev()
    file.change -> i_file.val(file.val())
    $(@).click -> file.click()

$(document).ready ->
  App.load_module()
  bind_datepicker()
  bind_timepicker()
  bind_file_input()