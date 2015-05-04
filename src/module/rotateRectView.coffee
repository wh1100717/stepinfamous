define (require, exports, module) ->
    "use strict"

    Modifier = require('famous/core/Modifier')
    Transform = require('famous/core/Transform')
    Surface = require('famous/core/Surface')
    View = require('famous/core/View')

    class RotateRectView extends View
        constructor: ->
            super
            _createRotatView.call(@)


    RotateRectView.DEFAULT_OPTIONS = {
        size: [200, 200]
        align: [0.5, 0.5]
        origin: [0.5, 0.5]
        color: "#FA5C4F"
        frequency: 2
    }

    _createRotatView = ->
        _$ = @
        rectSurface = new Surface {
            size: _$.options.size
            properties: {
                backgroundColor: _$.options.color
            }
            classes: ['backfaceVisibility']
        }
        initialTime = Date.now()
        centerSpinModifier = new Modifier {
            align: _$.options.align
            origin: _$.options.origin
            transform: ->
                Transform.rotateY(_$.options.frequency * 0.001 * (Date.now() - initialTime))
        }
        @add(centerSpinModifier).add(rectSurface)


    module.exports = RotateRectView
