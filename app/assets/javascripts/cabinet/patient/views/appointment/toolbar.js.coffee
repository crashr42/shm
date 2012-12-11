define([
  'jquery',
  'backbone',
  'widgets/user_finder/user_finder'
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
          @$el.find('#selected-doctor').text("You select: #{user.email}")
          @$el.find('#doctor-selector').user_finder('hide')
          @$el.find('#use-doctor').removeClass('hide').attr('data-id', user.id)
        , @)).user_finder('show')

    myDoctor: (e) -> @selected($(e.currentTarget).attr('data-id'), Math.round(new Date().getTime() / 1000)) if @selected

    useDoctor: (e) -> @selected($(e.currentTarget).attr('data-id'), Math.round(new Date().getTime() / 1000)) if @selected

    selected: (id) -> throw 'Implementation error'
)