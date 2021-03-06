define([
  'jquery',
  'bootstrap-datepicker',
  'bootstrap-timepicker',
  'page_size'
], ($) ->
  # Глобальный биндинг
  class Binder
    @binded = false

    # Вещаем виджет выбора дат
    bindDatepicker: ->
      $('input.datepicker').datepicker(
        format: 'dd.mm.yyyy',
        weekStart: 1,
        todayBtn: true,
        todayHighlight: true
      ).keydown((e)-> e.preventDefault())

    # Вещаем виджет выбора времени
    bindTimepicker: ->
      $('input.timepicker').timepicker()

    # Красивый file input
    bindFileInput: ->
      $('.b_file').each ->
        i_file = $(this).prev()
        file = $(this).parent().prev()
        file.unbind('change').on('change', -> i_file.val(file.val()))
        $(@).unbind('click').on('click', -> file.click())

    bindDropMenu: ->
      $('.dropmenu').unbind('click').on('click', (e) ->
        e.preventDefault()
        $(e.currentTarget).parent().find('ul').slideToggle()
      )

    minimizeButton: ->
      $('.btn-minimize').unbind('click').on('click', $.proxy((e) ->
        e.preventDefault()
        target = $(e.currentTarget).parent().parent().next('.box-content')
        unless target.css('display') == 'none'
          $('i', $(e.currentTarget)).removeClass('icon-chevron-up').addClass 'icon-chevron-down'
        else
          $('i', $(e.currentTarget)).removeClass('icon-chevron-down').addClass 'icon-chevron-up'
        target.slideToggle()
      , @))

    setNewContentHeight: ->
      content = $('#content')
      new_height = $.pageSize().windowHeight - content.innerHeight() + content.height() - content.offset().top - 20
      if new_height > content.children('div:visible').first().height()
        content.height(new_height)
      else
        content.height('auto')

    bindPageSize: ->
      $(window).resize(@setNewContentHeight)

    bind: ->
      @bindDatepicker()
      @bindTimepicker()
      @bindFileInput()
      @setNewContentHeight()
      @minimizeButton()

      unless @binded
        @bindDropMenu()
        @binded = true
        @bindPageSize()

  new Binder()
)