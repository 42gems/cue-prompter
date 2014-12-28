app.controller 'SharedButtonsCtrl', ($scope, $famous, $sce) ->
  Easing = $famous['famous/transitions/Easing'];
  IconWidth  = 48
  IconHeight = 36

  $scope.sharedButtons = 
    boxes: []
    status: 'closed'

  contents = [
    '<a id="fb" class="icon" target="_blank" href="https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Fcue-prompter.42gems.co%2F"></a>'
    '<a id="gplus" class="icon" target="_blank" href="https://plus.google.com/share?url=http%3A%2F%2Fcue-prompter.42gems.co%2F"></a>'
    '<a id="twitter" class="icon" target="_blank" href="https://twitter.com/intent/tweet?url=http%3A%2F%2Fcue-prompter.42gems.co%2F&text=Nice+cue-prompter!"></a>'
  ]

  i = 0
  while i < contents.length
    box =
      size: [IconWidth, IconHeight]
      curve: 'outElastic'
      position: new famous.transitions.Transitionable([-IconWidth, -10-(i * IconHeight), 0])
      content: contents[i]
    $scope.sharedButtons.boxes.push(box)
    i++

  $scope.openShared = ->
    i = 0
    while i < $scope.sharedButtons.boxes.length
      box = $scope.sharedButtons.boxes[i]
      box.position.set [0, -10-(i * IconHeight), 0],
        curve: Easing[box.curve]
        duration: 500
      i++
    $scope.sharedButtons.status = 'open'

  $scope.closeShared = ->
    i = 0
    while i < $scope.sharedButtons.boxes.length
      box = $scope.sharedButtons.boxes[i]
      box.position.set [-IconWidth, -10-(i * IconHeight), 0],
        duration: 100
      i++
    $scope.sharedButtons.status = 'closed'

  $scope.toggleShared = ->
    if $scope.sharedButtons.status is 'closed'
      $scope.openShared()
    else
      $scope.closeShared()

  $scope.renderHtml = (val) ->
    $sce.trustAsHtml(val)
