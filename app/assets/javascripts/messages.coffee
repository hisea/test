# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('App')

app.controller 'MessageCtrl', ['$scope', 'MessageService', ($scope, MessageService) ->
  $scope.load = ->
    $scope.selected_message = {}
    MessageService.index(1)
      .success (response)->
        $scope.messages = response.messages

  $scope.select = (message) ->
    $scope.selected_message = message

  $scope.create = ->
    MessageService.create($scope.newUser)
      .success (response) ->
        $scope.newUser = {}
        $scope.load()
  $scope.load()
]

app.factory 'MessageService', ($http, $q) ->
  factory = {}
  factory.index = (user_id)->
    $http.get('/api/messages.json', {'user_id': user_id})

  factory.create = (user) ->
    $http.post('/api/users.json', user)

  factory
