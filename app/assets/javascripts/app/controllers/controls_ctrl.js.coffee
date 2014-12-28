app.controller 'ControlsCtrl', ($scope, $famous, Transitionable) ->
  $scope.transitionable = Transitionable

  $scope.currentStateClass = ->
    if $scope.transitionable.isActive()
      'fa-pause'
    else
      'fa-play'

  $scope.togglePlay = ->
    if $scope.transitionable.isActive()
      $scope.transitionable.halt()
    else
      $scope.continueAnimation()

  $scope.backward = ->
    if $scope.transitionable.isActive()
      $scope.stop()
      $scope.continueAnimation()
    else
      $scope.transitionable.set([0,0,0])

  $scope.stop = ->
    if $scope.transitionable.isActive()
      $scope.transitionable.halt()
    $scope.transitionable.set([0,0,0])
