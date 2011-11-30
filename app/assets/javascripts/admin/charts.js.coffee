$ ->
  rows = $('#sign_ups_by_date .data tr')
  labels = ($(row).find('th').html() for row in rows)
  counts = ($(row).find('td .profile').length for row in rows)
  chart = $('#sign_ups_by_date .chart').chart
    template: 'analytics'
    tooltips: ("#{labels[index]}: #{count}" for count, index in counts)
    values: serie1: counts
  $('.show-data').click (e) ->
    e.preventDefault()
    $(e.target).toggleClass('expanded').parent().next('.data').toggle()
