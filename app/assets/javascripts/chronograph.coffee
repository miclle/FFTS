'use strict'

class Chronograph
  constructor: (id, settings) ->
    @element = document.getElementById(id)
    @settings = settings
    @millisecond = 0
    @second = 0
    @minute = 0
    @init()

  ###
    @second: 0 ~ 360
  ###
  setSecond: (second) ->
    @second = second

  ###
    @minute: 0 ~ 360
  ###
  setMinute: (minute) ->
    @minute = minute

  init: ->
    @canvas = document.createElement('canvas');
    @canvas.setAttribute('width', @settings.size)
    @canvas.setAttribute('height', @settings.size)

    @element.appendChild(@canvas);
    @dashboard()

  ###
    @deg: 0 ~ 360
  ###
  deg: (deg) =>
    (Math.PI/180) * deg - (Math.PI/180)*90

  dashboard: =>
    ctx = @canvas.getContext("2d")
    ctx.clearRect(0, 0, @settings.size, @settings.size)

    # minute
    ctx.beginPath()
    ctx.arc(@settings.size/2, @settings.size/2, @settings.size/2 - 12, 0, Math.PI*2, true)
    ctx.lineWidth = 22
    ctx.strokeStyle = "#000"
    ctx.globalAlpha = 0.325
    ctx.stroke()
    ctx.closePath()

    (=>
      degs = @minute / 180 * 360
      ctx.beginPath()
      ctx.arc(@settings.size/2, @settings.size/2, @settings.size/2 - 12, @deg(0), @deg(degs))
      ctx.lineWidth = 22
      ctx.strokeStyle = "#FF00FF"
      ctx.globalAlpha = 0.4
      ctx.stroke()
      ctx.closePath();
    )()


    # second
    ctx.beginPath()
    ctx.arc(@settings.size/2, @settings.size/2, @settings.size/2 - 38.5, 0, Math.PI*2, true)
    ctx.lineWidth = 22
    ctx.strokeStyle = "#000"
    ctx.globalAlpha = 0.225
    ctx.stroke()
    ctx.closePath()

    (=>
      degs = @second / 180 * 360
      ctx.beginPath()
      ctx.arc(@settings.size/2, @settings.size/2, @settings.size/2 - 38.5, @deg(0), @deg(degs))
      ctx.lineWidth = 22
      ctx.strokeStyle = "#0FF"
      ctx.globalAlpha = 0.4
      ctx.stroke()
      ctx.closePath();
    )()


    # millisecond
    ctx.beginPath()
    ctx.arc(@settings.size/2, @settings.size/2, @settings.size/2 - 55, 0, Math.PI*2, true)
    ctx.lineWidth = 2
    ctx.strokeStyle = "#000"
    ctx.globalAlpha = 0.225
    ctx.stroke()
    ctx.closePath()

    ctx.beginPath()
    degs = @millisecond / 180 * 360
    ctx.arc(@settings.size/2, @settings.size/2, @settings.size/2 - 55, @deg(0), @deg(degs))
    ctx.lineWidth = 2
    ctx.strokeStyle = "#FFF"
    ctx.globalAlpha = 0.155
    ctx.stroke()
    ctx.closePath();

  run: ->
    timer = setInterval((=>
      @millisecond = 0 if @millisecond == 180
      @millisecond++
      @dashboard()
    ), 1)

window.Chronograph = Chronograph


