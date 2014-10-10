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
    @dashboard()

  deg: (deg) ->
    (Math.PI/180) * deg - (Math.PI/180)*90

  dashboard: ->
    ctx = @canvas.getContext("2d")

    ctx.clearRect(0, 0, @settings.size, @settings.size)


    # hour
    ctx.beginPath()
    ctx.arc(@settings.size/2, @settings.size/2, @settings.size/2 - 12, 0, Math.PI*2, true)
    ctx.lineWidth = 22
    ctx.strokeStyle = "#000000"
    ctx.globalAlpha = 0.325
    ctx.shadowBlur  = 0
    ctx.stroke()
    ctx.closePath()

    # minute
    ctx.beginPath()
    ctx.arc(@settings.size/2, @settings.size/2, @settings.size/2 - 38.5, 0, Math.PI*2, true)
    ctx.lineWidth = 22
    ctx.strokeStyle = "#000000"
    ctx.globalAlpha = 0.225
    ctx.shadowBlur  = 0
    ctx.stroke()
    ctx.closePath()


    # second
    ctx.beginPath()
    ctx.arc(@settings.size/2, @settings.size/2, @settings.size/2 - 55, 0, Math.PI*2, true)
    ctx.lineWidth = 2
    ctx.strokeStyle = "#000000"
    ctx.globalAlpha = 0.225
    ctx.shadowBlur  = 0
    ctx.stroke()
    ctx.closePath()

    ctx.globalAlpha = 125

window.Chronograph = Chronograph