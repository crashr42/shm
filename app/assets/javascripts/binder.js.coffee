define([
  'jquery',
  'bootstrap-datepicker',
  'bootstrap-timepicker'
], ($) ->
  # Глобальный биндинг
  class Binder
    # Вещаем виджет выбора дат
    bindDatepicker: ->
      $('input.datepicker').datepicker(
        format: 'dd.mm.yyyy',
        weekStart: 1,
        todayBtn: true,
        todayHighlight: true
      ).keydown(-> return false)

    # Вещаем виджет выбора времени
    bindTimepicker: ->
      $('input.timepicker').timepicker()

    # Красивый file input
    bindFileInput: ->
      $('.b_file').each ->
      i_file = $(this).prev()
      file = $(this).parent().prev()
      file.change -> i_file.val(file.val())
      $(@).click -> file.click()

    bind: ->
      @bindDatepicker()
      @bindTimepicker()
      @bindFileInput()

  new Binder()
)