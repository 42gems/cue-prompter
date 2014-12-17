app.controller 'LogicCtrl', ($scope, $famous, $modal) ->

  $scope.openModal = ->
    modalInstance = $modal.open
      templateUrl: "share_button_modal.html"
      controller: "ShareButtonModalInstanceCtrl"

    modalInstance.result.then ->
      console.log 'Done!'
    , ->
      console.log "Modal dismissed"
