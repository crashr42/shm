define([
  'jquery',
  'backbone',
  'views/index',
  'views/user',
  'views/parameter/index',
  'views/parameter/edit',
  'views/parameter/new'
], ($, Backbone, Index, User, ParameterIndex, ParameterEdit, ParameterNew) ->
  Backbone.View.extend
    initialize: ->
      @index = new Index()
      @user = new User()
      @parameterIndex = new ParameterIndex()
      @parameterEdit = new ParameterEdit()
      @parameterNew = new ParameterNew()

    showIndex: -> @index.render $.proxy(((v) -> @$el.html(v.el)), @)
    showUser: -> @user.render $.proxy(((v) -> @$el.html(v.el)), @)
    showParameterIndex: -> @parameterIndex.render $.proxy(((v) -> @$el.html(v.el)), @)
    showParameterEdit: (id) -> @parameterEdit.render $.proxy(((v) -> @$el.html(v.el)), @), id
    showParameterNew: -> @parameterNew.render $.proxy(((v) -> @$el.html(v.el)), @)
)