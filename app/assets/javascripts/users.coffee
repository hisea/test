# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('App', [])

app.controller 'UserCtrl', ['$scope', '$http', ($scope, $http) ->

  $scope.load = ->
    $http.get('api/users.json')
      .success (response)->
        $scope.users = response.users

  $scope.create = ->
    $http.post('api/users.json',$scope.newUser)
      .success (response) ->
        $scope.newUser = {}
        $scope.load()
  $scope.load()
]

# angular.module('App').service 'UserService', ($http, $q) ->
#   return
#     'create': create,
#     'get', get,
#     'index', index

#   create = ->
#     request = $http
#       'method': 'post',
#       'url': '/api/users.json'
