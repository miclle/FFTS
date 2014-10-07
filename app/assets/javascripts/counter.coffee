'use strict'

class Counter
  constructor: (id, settings) ->
    @element = document.getElementById(id)

    @glob = settings
    @init()

  init: ->

    @canvas = document.createElement('canvas');
    @canvas.setAttribute('width', @glob.size)
    @canvas.setAttribute('height', @glob.size)

    @element.appendChild(@canvas);

    @glob.total   = Math.floor((@glob.endDate - @glob.startDate) / 86400)
    @glob.days    = Math.floor((@glob.endDate - @glob.now) / 86400)
    @glob.hours   = 24 - Math.floor((@glob.endDate - @glob.now) % 86400 / 3600)
    @glob.minutes = 60 - Math.floor((@glob.endDate - @glob.now) % 86400 % 3600 / 60)
    @glob.seconds = 60 - Math.floor((@glob.endDate - @glob.now) % 86400 % 3600 % 60)
    @glob.secLeft = Math.floor(@glob.endDate - @glob.now)

    return if (@glob.now >= @glob.endDate)

    @meter()
    @start()


  deg: (deg) ->
    (Math.PI/180) * deg - (Math.PI/180)*90

  meter: ->
    @glob.secLeft--

    ctx = @canvas.getContext("2d")

    ctx.clearRect(0, 0, @canvas.width, @canvas.height)

    ctx.beginPath()

    ctx.strokeStyle = @glob.secondsColor

    ctx.shadowBlur    = 10
    ctx.shadowOffsetX = 0
    ctx.shadowOffsetY = 0
    ctx.shadowColor   = @glob.secondsGlow

    degs = (360 / Math.floor(@glob.endDate - @glob.startDate)) * (Math.floor(@glob.endDate - @glob.startDate) - @glob.secLeft)
    ctx.arc(@canvas.width/2, @canvas.height/2, 390/2, @deg(0), @deg(degs))
    ctx.lineWidth = 5
    ctx.stroke()

    $(".timer .secs").text(60 - @glob.seconds)
    $(".timer .mins").text(60 - @glob.minutes)
    $(".timer .hrs").text(24 - @glob.hours)
    $(".timer .days").text(@glob.days)

  start: =>
    cdown = setInterval((=>

      if ( @glob.seconds > 59 )

        clearInterval(cdown) if (60 - @glob.minutes == 0 && 24 - @glob.hours == 0 && @glob.days == 0)

        @glob.seconds = 1

        if (@glob.minutes > 59)
          @glob.minutes = 1

          if (@glob.hours > 23)
            @glob.hours = 1
            if (@glob.days > 0)
              @glob.days--
          else
            @glob.hours++
        else
          @glob.minutes++
      else
        @glob.seconds++

      @meter()
    ),1000)

window.Counter = Counter
