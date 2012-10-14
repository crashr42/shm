//= require ./app
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

function bind_datepicker() {
    $('.datepicker').datepicker({
        format:'dd.mm.yyyy',
        weekStart:1,
        todayBtn:true,
        todayHighlight:true,
        autoclose:true
    }).keydown(function () {
            return false
        });
}

function bind_timepicker() {
    $('.timepicker').timepicker();
}

bind_datepicker();
bind_timepicker();

$(document).ready(function(){
    App.load_module();
});