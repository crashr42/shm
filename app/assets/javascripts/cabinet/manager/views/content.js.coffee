define([
  'jquery',
  'backbone',
  'views/index',
  'views/user',
  'views/parameter/index',
  'views/parameter/edit',
  'views/parameter/new',
  'views/bid/index',
  'views/bid/show',
  'views/rule_parameter_input/index'
], (
  $,
  Backbone,
  Index,
  User,
  ParameterIndex,
  ParameterEdit,
  ParameterNew,
  BidIndex,
  BidShow,
  RuleParameterInputIndex
) ->
  Backbone.View.extend
    initialize: ->
      @index = new Index()
      @user = new User()
      @parameterIndex = new ParameterIndex()
      @parameterEdit = new ParameterEdit()
      @parameterNew = new ParameterNew()
      @bidIndex = new BidIndex()
      @bidShow = new BidShow()
      @ruleParameterInputIndex = new RuleParameterInputIndex()

    showIndex: -> @index.render $.proxy(((v) -> @$el.html(v.el)), @)
    showUser: -> @user.render $.proxy(((v) -> @$el.html(v.el)), @)
    showParameterIndex: -> @parameterIndex.render $.proxy(((v) -> @$el.html(v.el)), @)
    showParameterEdit: (id) -> @parameterEdit.render $.proxy(((v) -> @$el.html(v.el)), @), id
    showParameterNew: -> @parameterNew.render $.proxy(((v) -> @$el.html(v.el)), @)
    showBidIndex: -> @bidIndex.render $.proxy(((v) -> @$el.html(v.el)), @)
    showBidShow: (id) -> @bidShow.render $.proxy(((v) -> @$el.html(v.el)), @), id
    showRuleParameterInputIndex: -> @ruleParameterInputIndex.render $.proxy(((v) -> @$el.html(v.el)), @)
)