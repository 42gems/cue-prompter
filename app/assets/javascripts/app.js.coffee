app = angular.module('prompter', ['famous.angular'])

app.controller 'MainCtrl', ['$scope', '$famous', '$timeout', ($scope, $famous, $timeout) ->
    $scope.verticalFlexibleLayoutOptions =
      direction: 1
      ratios: [1, true]

    $scope.flexibleLayoutOptions =
      ratios: [1, true]

    $scope.footerFlexibleLayoutOptions =
      ratios: [true, 1, true]

    $scope.data =
      content: 'Replace this with your content!'
      fontSize: 50
      speed: 10
      height: 0

    $scope.transitionable = new famous.transitions.Transitionable([0, 0, 0])

    $scope.adjustPrompterSize = ->
      setTimeout ( ->
        surface = $famous.find('#content')[0].renderNode
        if surface
          content = surface.getContent()
          height = $(content).height()
          surface.setSize [undefined, height]
          $scope.continueAnimation() if $scope.transitionable.isActive()
      ), 100

    $scope.getHeight = ->
      surface = $famous.find('#content')[0].renderNode
      if surface
        content = surface.getContent()
        height = $(content).height()
        $scope.data.height = height if height
        height
      else
        undefined

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

    $scope.currentCoef = ->
      height = $scope.getHeight()
      done = $scope.transitionable.get()[1]
      ( height + done ) / height

    $scope.progressBarSize = ->
      if $scope.fullProgressBarSize()
        (1 - $scope.currentCoef()) * $scope.fullProgressBarSize()[0]
      else
        0

    $scope.fullProgressBarSize = ->
      surface = $famous.find('.footer-background')[0].renderNode
      surface.getSize()

    $scope.$watch $scope.getHeight, $scope.adjustPrompterSize

    $scope.$watch 'data.fontSize', ->
      surface = $famous.find('#content')[0].renderNode
      surface.setProperties
        fontSize: $scope.data.fontSize + 'px'

    $scope.$watch 'data.speed', ->
      $scope.continueAnimation() if $scope.transitionable.isActive()

    $scope.continueAnimation = ->
      $scope.transitionable.halt() if $scope.transitionable.isActive()
      height = $scope.getHeight()
      doneHeight = $scope.transitionable.get()[1]
      leftHeight = height + doneHeight
      duration = leftHeight / $scope.data.speed * 1000
      $scope.transitionable.set([0, -height, 0], { duration: duration })

    # events
    #
    $scope.progressBarMouseSync = new famous.inputs.MouseSync()

    $scope.updateByProgressBar = (obj) ->
      height = $scope.getHeight()
      fullBarWidth = $scope.fullProgressBarSize()
      if height && fullBarWidth
        fullBarWidth = fullBarWidth[0]
        offsetBar = (obj.clientX - 100)
        if offsetBar >= 0 && offsetBar <= fullBarWidth
          ratio = offsetBar / fullBarWidth
          shift = height * ratio
          if $scope.transitionable.isActive()
            $scope.transitionable.halt()
            $scope.transitionable.set([0, -shift, 0])
            $scope.continueAnimation()
          else
            $scope.transitionable.set([0, -shift, 0])

    $scope.progressBarMouseSync.on 'start', $scope.updateByProgressBar
    $scope.progressBarMouseSync.on 'update', $scope.updateByProgressBar
  ]
