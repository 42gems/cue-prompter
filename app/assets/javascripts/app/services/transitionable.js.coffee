app.service 'Transitionable', ($famous, $rootScope) ->
  service =
    transitionable: new famous.transitions.Transitionable([0, 0, 0])
    
    setValue: (value) ->
      service.transitionable = value
      $rootScope.$broadcast 'transitionable.update'

    getValue: ->
      service.transitionable
