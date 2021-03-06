// Generated by CoffeeScript 1.9.2
var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

define(function(require, exports, module) {
  "use strict";
  var Modifier, RotateRectView, Surface, Transform, View, _createRotatView;
  Modifier = require('famous/core/Modifier');
  Transform = require('famous/core/Transform');
  Surface = require('famous/core/Surface');
  View = require('famous/core/View');
  RotateRectView = (function(superClass) {
    extend(RotateRectView, superClass);

    function RotateRectView() {
      RotateRectView.__super__.constructor.apply(this, arguments);
      _createRotatView.call(this);
    }

    return RotateRectView;

  })(View);
  RotateRectView.DEFAULT_OPTIONS = {
    size: [200, 200],
    align: [0.5, 0.5],
    origin: [0.5, 0.5],
    color: "#FA5C4F",
    frequency: 2
  };
  _createRotatView = function() {
    var centerSpinModifier, initialTime, rectSurface;
    rectSurface = new Surface({
      size: this.options.size,
      properties: {
        backgroundColor: this.options.color
      },
      classes: ['backfaceVisibility']
    });
    initialTime = Date.now();
    centerSpinModifier = new Modifier({
      align: this.options.align,
      origin: this.options.origin,
      transform: (function(_this) {
        return function() {
          return Transform.rotateY(_this.options.frequency * 0.001 * (Date.now() - initialTime));
        };
      })(this)
    });
    return this.add(centerSpinModifier).add(rectSurface);
  };
  return module.exports = RotateRectView;
});
