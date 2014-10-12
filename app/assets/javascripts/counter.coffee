'use strict'

###
  @param  :
    id: DOM id attribute
    settings: Specify options in {}. May be on of size, times or color.
  @example:
    new Counter('downloader', {
      size: 420,
      secondsColor : "#ffdc50",
      secondsGlow  : "#ffdc50",
      startDate    : 1412698808,
      endDate      : 1412704208,
      now          : 1412701317
    });
###
class Counter
  constructor: (id, settings) ->
    @element = document.getElementById(id)
    @settings = settings
    @init()

  init: ->
    @canvas = document.createElement('canvas');
    @canvas.setAttribute('width', @settings.size)
    @canvas.setAttribute('height', @settings.size)

    @element.appendChild(@canvas);

    @settings.total   = Math.floor((@settings.endDate - @settings.startDate) / 86400)
    @settings.days    = Math.floor((@settings.endDate - @settings.now) / 86400)
    @settings.hours   = 24 - Math.floor((@settings.endDate - @settings.now) % 86400 / 3600)
    @settings.minutes = 60 - Math.floor((@settings.endDate - @settings.now) % 86400 % 3600 / 60)
    @settings.seconds = 60 - Math.floor((@settings.endDate - @settings.now) % 86400 % 3600 % 60)
    @settings.secLeft = Math.floor(@settings.endDate - @settings.now)

    @meter()
    @start()


  deg: (deg) ->
    (Math.PI/180) * deg - (Math.PI/180)*90


  meter: ->
    @settings.secLeft--

    ctx = @canvas.getContext("2d")

    ctx.clearRect(0, 0, @settings.size, @settings.size)

    ctx.beginPath()
    ctx.arc(@settings.size/2, @settings.size/2, @settings.size/2-10, 0, Math.PI*2, true)
    ctx.lineWidth = 5
    ctx.strokeStyle = "#1C1C1C"
    ctx.shadowBlur  = 0
    ctx.stroke()
    ctx.closePath()

    ctx.beginPath()
    ctx.arc(@settings.size/2, @settings.size/2, @settings.size/2-6, 0, Math.PI*2, true)
    ctx.lineWidth = 1
    ctx.strokeStyle = "#000000"
    ctx.shadowBlur  = 0
    ctx.stroke()
    ctx.closePath()

    ctx.beginPath()
    ctx.arc(@settings.size/2, @settings.size/2, @settings.size/2-13, 0, Math.PI*2, true)
    ctx.lineWidth = 1
    ctx.strokeStyle = "#444444"
    ctx.shadowBlur  = 0
    ctx.stroke()
    ctx.closePath()

    ctx.beginPath()
    ctx.font = "12px BebasNeueRegular"
    ctx.textAlign = "center"
    ctx.fillStyle = "#444"
    ctx.shadowBlur  = 0
    ctx.fillText("Fast File Transfer Station", @settings.size/2, @settings.size - 60)
    ctx.fillText("@FFTS.IO", @settings.size/2, @settings.size - 42)
    ctx.closePath()

    if (@settings.now < @settings.endDate)
      ctx.beginPath()
      ctx.strokeStyle = @settings.secondsColor
      ctx.shadowBlur    = 10
      ctx.shadowOffsetX = 0
      ctx.shadowOffsetY = 0
      ctx.shadowColor   = @settings.secondsGlow

      degs = (360 / Math.floor(@settings.endDate - @settings.startDate)) * (Math.floor(@settings.endDate - @settings.startDate) - @settings.secLeft)
      ctx.arc(@canvas.width/2, @canvas.height/2, @settings.size/2-10, @deg(0), @deg(degs))
      ctx.lineWidth = 5
      ctx.stroke()
      ctx.closePath();

      $(".timer .secs").text(60 - @settings.seconds)
      $(".timer .mins").text(60 - @settings.minutes)
      $(".timer .hrs").text(24 - @settings.hours)
      $(".timer .days").text(@settings.days)


  start: =>
    counterIntervalId = setInterval((=>
      if ( @settings.seconds > 59 )
        if (60 - @settings.minutes == 0 && 24 - @settings.hours == 0 && @settings.days == 0)
          clearInterval(counterIntervalId)
          return

        @settings.seconds = 1

        if (@settings.minutes > 59)
          @settings.minutes = 1

          if (@settings.hours > 23)
            @settings.hours = 1
            @settings.days-- if @settings.days > 0
          else
            @settings.hours++
        else
          @settings.minutes++
      else
        @settings.seconds++

      @meter()
    ),1000)


window.Counter = Counter