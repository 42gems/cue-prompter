app.controller "ShareButtonModalInstanceCtrl", ($scope, $modalInstance) ->
  $scope.done = ->
    $modalInstance.close "Done!"

  $scope.cancel = ->
    $modalInstance.dismiss "Cancelled"
