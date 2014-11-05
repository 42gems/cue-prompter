$(document).ready ->
  Surface = famous.core.Surface
  Modifier = famous.core.Modifier
  Transform = famous.core.Transform
  Engine = famous.core.Engine
  StateModifier = famous.modifiers.StateModifier
  Transitionable = famous.transitions.Transitionable
  Easing = famous.transitions.Easing

  context = Engine.createContext()

  surface1 = new Surface
    size: [100, 100]
    properties:
      backgroundColor: 'gray'
      textAlign: 'center'
      fontSize: '100px'
      lineHeight: '100px'
      borderRadius: '50px'
    content: '4'

  surface2 = new Surface
    size: [100, 100]
    properties:
      backgroundColor: 'red'
      textAlign: 'center'
      fontSize: '100px'
      lineHeight: '100px'
      borderRadius: '50px'
    content: '2'

  originModifier = new Modifier
    align: [0.5, 0.5]
    origin: [0.5, 0.5]
    opacity: 0.8

  moveTransitionable = new Transitionable([0, 0, 1])

  initialTranslateModifier1 = new StateModifier
    transform: Transform.translate(-300, 0, 0)

  rotateModifier1 = new Modifier
    transform: ->
      Transform.rotateZ(moveTransitionable.get()[1])

  moveModifier1 = new Modifier
    origin: [0.5, 0.5]
    transform: ->
      scale = moveTransitionable.get()[2]
      yTranslate = - (1-scale) * 100
      Transform.translate(moveTransitionable.get()[0], yTranslate, scale)

  scaleModifier1 = new Modifier
    transform: ->
      scale = moveTransitionable.get()[2]
      Transform.scale(scale, scale, scale)

  initialTranslateModifier2 = new StateModifier
    transform: Transform.translate(300, 0, 0)

  rotateModifier2 = new Modifier
    transform: ->
      Transform.rotateZ(moveTransitionable.get()[1])

  moveModifier2 = new Modifier
    origin: [0.5, 0.5]
    transform: ->
      scale = 1/moveTransitionable.get()[2]
      yTranslate = - (1-scale) * 100
      Transform.translate(-moveTransitionable.get()[0], yTranslate, scale)

  scaleModifier2 = new Modifier
    transform: ->
      scale = moveTransitionable.get()[2]
      Transform.scale(1/scale, 1/scale, 1/scale)

  origin = context.add(originModifier)

  origin.add(initialTranslateModifier1).add(moveModifier1).add(rotateModifier1).add(scaleModifier1).add(surface1)
  origin.add(initialTranslateModifier2).add(moveModifier2).add(rotateModifier2).add(scaleModifier2).add(surface2)

  angle = 0

  animation = ->
    moveTransitionable.set [300, angle + Math.PI*2, 2], { duration: 1000, curve: Easing.inOutSine }
    moveTransitionable.set [600, angle + Math.PI*4, 1], { duration: 1000, curve: Easing.inOutSine }
    moveTransitionable.set [300, angle + Math.PI*6, 0.5], { duration: 1000, curve: Easing.inOutSine }
    moveTransitionable.set [0, angle + Math.PI*8, 1], { duration: 1000, curve: Easing.inOutSine }, ->
      angle += Math.PI*8
      animation()

  animation()
