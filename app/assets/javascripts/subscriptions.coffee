# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('App')

app.controller 'SubscriptionCtrl', ['$scope', 'SubscriptionService', ($scope, SubscriptionService) ->
  $scope.init = (user_id)->
    $scope.user_id = user_id
    $scope.load()

  $scope.load = ->
    SubscriptionService.index($scope.user_id)
      .success (response)->
        $scope.active = response.active
        $scope.cancelled = response.cancelled

  $scope.create = ->
    SubscriptionService.create($scope.user_id)
      .success (response) ->
        $scope.load()

  $scope.cancel = (subscription)->
    SubscriptionService.cancel(subscription.id)
      .success (response) ->
        $scope.load()

  $scope.reactivate = (subscription)->
    SubscriptionService.reactivate(subscription.id)
      .success (response) ->
        $scope.load()
]

app.factory 'SubscriptionService', ($http, $q) ->
  factory = {}
  factory.index = (user_id)->
    $http(
      'method': 'GET'
      'url': '/api/subscriptions.json',
      'params':
        'user_id': user_id
    )

  factory.create = (user_id) ->
    $http(
      'url': '/api/subscriptions.json',
      'method': 'POST',
      'data':
        'user_id': user_id
    )

  factory.cancel = (subscription_id) ->
    $http(
      'url': "/api/subscriptions/#{subscription_id}/cancel.json",
      'method': 'POST',
    )
  factory.reactivate = (subscription_id) ->
    $http(
      'url': "/api/subscriptions/#{subscription_id}/reactivate.json",
      'method': 'POST',
    )
  factory
