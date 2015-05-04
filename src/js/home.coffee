define (require, exports, module) ->
    "use strict"

    Engine = require("famous/core/Engine")

    RotateRectView = require("module/rotateRectView")

    mainContext = Engine.createContext()
    mainContext.setPerspective(1000)
    
    Home = {}

    Home.init = ->
        view1 = new RotateRectView {
            align: [0.3, 0.3]
            origin: [0.3, 0.3]
            size: [200, 200]
            frequency: 2
        }

        view2 = new RotateRectView {
            align: [0.7, 0.7]
            origin: [0.7, 0.7]
            size: [100, 100]
            frequency: 4
            color: "#7EDC7B"
        }

        view3 = new RotateRectView {
            align: [0.3, 0.7]
            origin: [0.3, 0.7]
            size: [120, 80]
            frequency: 0.5
            color: "black"
        }

        mainContext.add(view1)
        mainContext.add(view2)
        mainContext.add(view3)

    module.exports = Home