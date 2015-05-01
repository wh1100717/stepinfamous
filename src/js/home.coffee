define (require, exports, module) ->
    "use strict"

    Engine = require("famous/core/Engine")

    RotateRect = require("module/rotateRect")

    mainContext = Engine.createContext()
    mainContext.setPerspective(1000)
    
    Home = {}

    Home.init = ->
        (new RotateRect {
            position: {
                align: [0.3, 0.3]
                origin: [0.3, 0.3]
            }
            size: [200, 200]
            frequency: 2
        }).init(mainContext)

        (new RotateRect {
            position: {
                align: [0.7, 0.7]
                origin: [0.7, 0.7]
            }
            size: [100, 100]
            frequency: 4
            color: "#7EDC7B"
        }).init(mainContext)

        (new RotateRect {
            position: {
                align: [0.3, 0.7]
                origin: [0.3, 0.7]
            }
            size: [120, 80]
            frequency: 0.5
            color: "black"
        }).init(mainContext)

    module.exports = Home