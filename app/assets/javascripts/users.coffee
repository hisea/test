# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('App', [])

app.controller 'UserCtrl', ['$scope', 'UserService', ($scope, UserService) ->
  $scope.load = ->
    UserService.index()
      .success (response)->
        $scope.users = response.users

  $scope.create = ->
    UserService.create($scope.newUser)
      .success (response) ->
        $scope.newUser = {}
        $scope.load()

  $scope.load()
]

app.factory 'UserService', ($http, $q) ->
  userService = {}
  userService.index = ->
    $http.get('/api/users.json')

  userService.create = (user) ->
    $http.post('/api/users.json', user)

  userService
