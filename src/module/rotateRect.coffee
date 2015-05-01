define (require, exports, module) ->
    "use strict"

    Modifier = require('famous/core/Modifier')
    Transform = require('famous/core/Transform')
    Surface = require('famous/core/Surface')

    class RotateRect
        constructor: (config = {}) ->
            @position = if config.position? then config.position else {align: [0.5, 0.5], origin: [0.5, 0.5]}
            @size = if config.size? then config.size else [200, 200]
            @color = if config.color? then config.color else "#FA5C4F"
            @frequency = if config.frequency? then config.frequency else 2
        init: (mainContext) ->
            _$ = @
            rectSurface = new Surface {
                size: _$.size
                properties: {
                    backgroundColor: _$.color
                }
                classes: ['backfaceVisibility']
            }
            initialTime = Date.now()
            centerSpinModifier = new Modifier {
                align: _$.position.align
                origin: _$.position.origin
                transform: -> Transform.rotateY(_$.frequency * 0.001 * (Date.now() - initialTime))
            }
            mainContext.add(centerSpinModifier).add(rectSurface)

    module.exports = RotateRect
