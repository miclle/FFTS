'use strict'

###
  @param  :
    id: DOM id attribute
    settings: Specify options in {}. May be on of size.
  @example:
    new Chronograph('chronograph', {
      size: 420
    });
###
class Chronograph
  constructor: (id, settings) ->
    @element = document.getElementById(id)
    @settings = settings
    @millisecond = 0
    @second = 0
    @minute = 0
    @init()


  init: ->
    @canvas = document.createElement('canvas')
    @canvas.setAttribute('width', @settings.size)
    @canvas.setAttribute('height', @settings.size)

    @element.appendChild(@canvas)
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
    ctx.arc(@settings.size/2, @settings.size/2, @settings.size/2 - 12, 0, Math.PI*2)
    ctx.lineWidth = 22
    ctx.strokeStyle = "#000"
    ctx.globalAlpha = 0.325
    ctx.shadowBlur  = 0
    ctx.stroke()
    ctx.closePath()

    (=>
      degs = @minute
      ctx.beginPath()
      ctx.arc(@settings.size/2, @settings.size/2, @settings.size/2 - 12, @deg(0), @deg(degs))
      ctx.lineWidth = 22
      ctx.strokeStyle = "#FF00FF"
      ctx.globalAlpha = 0.4
      ctx.shadowBlur  = 0
      ctx.stroke()
      ctx.closePath()
    )()


    # second
    ctx.beginPath()
    ctx.arc(@settings.size/2, @settings.size/2, @settings.size/2 - 38.5, 0, Math.PI*2)
    ctx.lineWidth = 22
    ctx.strokeStyle = "#000"
    ctx.globalAlpha = 0.225
    ctx.shadowBlur  = 0
    ctx.stroke()
    ctx.closePath()

    (=>
      degs = @second
      ctx.beginPath()
      ctx.arc(@settings.size/2, @settings.size/2, @settings.size/2 - 38.5, @deg(0), @deg(degs))
      ctx.lineWidth = 22
      ctx.strokeStyle = "#0FF"
      ctx.globalAlpha = 0.4
      ctx.shadowBlur  = 0
      ctx.stroke()
      ctx.closePath()
    )()


    # millisecond
    ctx.beginPath()
    ctx.arc(@settings.size/2, @settings.size/2, @settings.size/2 - 55, 0, Math.PI*2)
    ctx.lineWidth = 2
    ctx.strokeStyle = "#000"
    ctx.globalAlpha = 0.225
    ctx.shadowBlur  = 0
    ctx.stroke()
    ctx.closePath()

    ctx.beginPath()
    degs = @millisecond
    ctx.arc(@settings.size/2, @settings.size/2, @settings.size/2 - 55, @deg(0), @deg(degs))
    ctx.lineWidth = 2
    ctx.strokeStyle = "#FFF"
    ctx.globalAlpha = 0.155

    ctx.shadowBlur    = 10
    ctx.shadowOffsetX = 0
    ctx.shadowOffsetY = 0
    ctx.shadowColor   = '#ffdc50'

    ctx.stroke()
    ctx.closePath()

    ctx.beginPath()
    ctx.shadowBlur  = 0
    ctx.globalAlpha = 1
    ctx.font = "12px BebasNeueRegular"
    ctx.textAlign = "center"
    ctx.fillStyle = "#444"
    ctx.fillText("Fast File Transfer Station", @settings.size/2, @settings.size - 90)
    ctx.fillText("@FFTS.IO", @settings.size/2, @settings.size - 72)
    ctx.closePath()

  run: ->
    # window.requestAnimationFrame: Must > IE10
    # window.setImmediate: only IE10
    # setInterval: delay minimum is 15.6ms(CPU 64 fps) ~= 16ms
    timer = setInterval((=>
      @millisecond = 0 if @millisecond >= 360
      @millisecond = @millisecond + 360 / 1000 * 16
      @dashboard()
    ), 16)


window.Chronograph = Chronograph
