'use strict'

class Chronograph
  constructor: (id, settings) ->
    @element = document.getElementById(id)
    @settings = settings
    @init()

  init: ->
    @canvas = document.createElement('canvas');
    @canvas.setAttribute('width', @settings.size)
    @canvas.setAttribute('height', @settings.size)

    @element.appendChild(@canvas);


  deg: (deg) ->
    (Math.PI/180) * deg - (Math.PI/180)*90

window.Chronograph = Chronograph