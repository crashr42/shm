App.module('/cabinet/manager/parameter/new', ->
  $ = jQuery

  $('.show-parameter-dialog').click -> $("#modal-#{$(@).attr('data-type')}").modal('show')

  do ->
    $('#select-p-add-new-value-button').click ->
      value = $('#select-p-new-value').val()
      box = $('<div class="alert alert-info"></div>')
      hidden = $('<input type="hidden" name="parameter[value][]" value="' + value + '">')
      def = $("<input name='parameter[default]' value='#{value}' type='radio'>")
      label = $("<label class='as-default radio'>#{value}</label>").prepend def
      button = $('<button type="button" class="close" data-dismiss="alert">&times;</button>')
      button.click -> $(@).parent().remove()
      box.append button, hidden, label
      $('#select-p-values-box').append box
)