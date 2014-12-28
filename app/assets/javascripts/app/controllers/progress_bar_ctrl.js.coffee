app.controller 'ProgressBarCtrl', ($scope, $famous, Transitionable) ->

  $scope.bar = 
    backgroundOptions:
      size: [undefined, 40]
      properties:
        background: '#0F1417'
        border: '2px solid #001F30'
        borderRadius: '10px'
    pointerOptions:
      properties:
        background: '#03080A'
        border: '4px solid black'
        borderRadius: '8px'
    progressBarOptions:
      properties:
        background: '#003A59'
        borderTop:    '2px solid rgba(4, 3, 8, 0.75)'
        borderBottom: '2px solid rgba(4, 3, 8, 0.75)'

  $scope.transitionable = Transitionable.transitionable
  $scope.progressBarMouseSync = new famous.inputs.MouseSync()

  $scope.currentCoef = ->
    height = $scope.getContentHeight()
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

  $scope.getSharerSize = ->
    surface = $famous.find('#sharer')[0].renderNode
    surface.getSize()

  $scope.updateByProgressBar = (obj) ->
    height = $scope.getContentHeight()
    fullBarWidth = $scope.fullProgressBarSize()
    sharerWidth  = $scope.getSharerSize()[0]
    if height && fullBarWidth
      fullBarWidth = fullBarWidth[0]
      offsetBar = (obj.clientX - sharerWidth)
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
