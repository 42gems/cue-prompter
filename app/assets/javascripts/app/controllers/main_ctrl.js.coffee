app.controller 'MainCtrl', ($scope, $famous, $timeout, Transitionable) ->
  $scope.verticalFlexibleLayoutOptions =
    direction: 1
    ratios: [1, true]

  $scope.flexibleLayoutOptions =
    ratios: [1, 3, 1]

  $scope.data =
    content: 'Replace this with your content!'
    fontSize: 50
    speed: 10
    height: 0

  $scope.mode =
    dark:
      background: '#243037'
      color: 'white'
      dimmer: 'btn-dimmer-light'
    light:
      background: '#F0EAD5'
      color: 'black'
      dimmer: 'btn-dimmer-dark'
  
  $scope.mode.current = $scope.mode.dark
  $scope.transitionable = Transitionable.transitionable

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
