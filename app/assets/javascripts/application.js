//= require ./app
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require twitter/bootstrap
//= require fullcalendar
//= require moment
//= require rails.validations
//= require_tree .

function bind_datepicker() {
    $('input.datepicker').datepicker({
        format:'dd.mm.yyyy',
        weekStart:1,
        todayBtn:true,
        todayHighlight:true
    }).keydown(function () {
            return false
        });
}

function bind_timepicker() {
    $('input.timepicker').timepicker();
}

bind_datepicker();
bind_timepicker();

$(document).ready(function(){
    App.load_module();
    $('.b_file').each(function () {
        var i_file = $(this).prev();
        var file = $(this).parent().prev();
        file.change(function(){
            i_file.val(file.val());
        });
        $(this).click(function(){
            file.click();
        })
    });
});
