$ = jQuery

$(document).ready ->
  $('#parameter_type_selector').change ->
    alert $(@).val()