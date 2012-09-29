//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

$('.datepicker').datepicker({
    format: 'dd.mm.yyyy',
    weekStart: 1,
    todayBtn: true,
    todayHighlight: true,
    autoclose: true
}).keydown(function() { return false });

$('.timepicker').timepicker();