app = angular
.module('tejas', ['ngAnimate', 'ui.router'])

.directive('expandLetter', ($timeout) ->
  return {
    link: (scope, element, attrs) ->
      $timeout( ->
        angular.element(element).addClass('expanded')
      , 2400)
  }
)    

.controller('site', ($scope) ->
  
  $scope.layer = { active: 'home' }
  
  $scope.open_layer = (layer) ->
    if layer != $scope.layer.active
      $scope.layers = false
    $scope.layer.active = layer)