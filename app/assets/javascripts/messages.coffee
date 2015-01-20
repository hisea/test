# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('App')

app.controller 'MessageCtrl', ['$scope', 'MessageService', ($scope, MessageService) ->
  $scope.init = (user_id)->
    $scope.user_id = user_id
    $scope.load()

  $scope.load = ->
    $scope.selected_message = {}
    MessageService.index($scope.user_id)
      .success (response)->
        $scope.messages = response.messages

  $scope.select = (message) ->
    $scope.selected_message = message

  $scope.create = ->
    $scope.newMessage.user_id = $scope.user_id
    MessageService.create($scope.newMessage)
      .success (response) ->
        $scope.newMessage = {}
        $scope.load()
]

app.factory 'MessageService', ($http, $q) ->
  factory = {}
  factory.index = (user_id)->
    $http(
      'method': 'GET'
      'url': '/api/messages.json',
      'params':
        'user_id': user_id
    )

  factory.create = (newMessage) ->
    $http(
      'url': '/api/messages.json',
      'method': 'POST',
      'data': newMessage
    )

  factory
