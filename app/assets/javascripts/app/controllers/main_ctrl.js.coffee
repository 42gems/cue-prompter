app.controller 'MainCtrl', ($scope, $famous, $timeout, Transitionable, Data, Mode) ->
  $scope.transitionable = Transitionable
  $scope.data = Data
  $scope.mode = Mode
  $scope.mode.current = $scope.mode.dark

  $scope.verticalFlexibleLayoutOptions =
    direction: 1
    ratios: [1, true]

  $scope.flexibleLayoutOptions =
    ratios: [1, 3, 1]

  $scope.getContentHeight = ->
    surface = $famous.find('#content')[0].renderNode
    if surface
      content = surface.getContent()
      height = $(content).height()
      $scope.data.height = height if height
      height
    else
      undefined

  $scope.continueAnimation = ->
    $scope.transitionable.halt() if $scope.transitionable.isActive()
    height = $scope.getContentHeight()
    doneHeight = $scope.transitionable.get()[1]
    leftHeight = height + doneHeight
    duration = leftHeight / $scope.data.speed * 1000
    $scope.transitionable.set([0, -height, 0], { duration: duration })

  $scope.adjustPrompterSize = ->
    setTimeout ( ->
      surface = $famous.find('#content')[0].renderNode
      if surface
        content = surface.getContent()
        height = $(content).height()
        surface.setSize [undefined, height]
        $scope.continueAnimation() if $scope.transitionable.isActive()
    ), 100

  $scope.$watch $scope.getContentHeight, $scope.adjustPrompterSize

  $scope.$watch 'data.fontSize', ->
    surface = $famous.find('#content')[0].renderNode
    surface.setProperties
      fontSize: $scope.data.fontSize + 'px'

  $scope.$watch 'data.speed', ->
    $scope.continueAnimation() if $scope.transitionable.isActive()

  $scope.toggleMode = ->
    $scope.mode.current = if $scope.mode.current is $scope.mode.dark
      $scope.mode.light
    else
      $scope.mode.dark
