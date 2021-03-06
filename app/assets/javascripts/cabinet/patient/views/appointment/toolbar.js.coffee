define([
  'jquery',
  'backbone',
  'widgets/user_finder',
  'moment'
], ($, Backbone) ->
  Backbone.View.extend
    events:
      'click #doctor-selector': 'doctorSelector'
      'click #my-doctor': 'myDoctor'
      'click #use-doctor': 'useDoctor'

    doctorSelector: (e) ->
      $(e.currentTarget).user_finder(
        url: '/cabinet/patient/doctor/find'
        selected: $.proxy((user) ->
          @selected(user.id, Math.round(new Date().getTime() / 1000)) if @selected
          @$el.find('#doctor-selector').user_finder('hide')
          @$el.find('#use-doctor').removeClass('hide').attr('data-id', user.id).text(user.email)
        , @)).user_finder('show')

    currentDate: -> moment(@$el.find('.datepicker').first().val(), 'DD.MM.YYYY')

    myDoctor: (e) -> @selected($(e.currentTarget).attr('data-id'), @currentDate() / 1000) if @selected

    useDoctor: (e) -> @selected($(e.currentTarget).attr('data-id'), @currentDate() / 1000) if @selected

    selected: (id) -> throw 'Implementation error'
)