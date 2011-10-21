window.renderMap = ->
  if loc = $('#location').val()
    opt =
      zoom            : 10
      mapTypeId       : google.maps.MapTypeId.ROADMAP
      disableDefaultUI: true
    geocoder = new google.maps.Geocoder()
    geocoder.geocode
      address: loc
      (results, status)->
        if status is google.maps.GeocoderStatus.OK
          opt.center = results[0].geometry.location
          map = new google.maps.Map $(".map")[0], opt

renderMap()
