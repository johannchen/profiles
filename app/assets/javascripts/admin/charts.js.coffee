$ ->
  labels = ($(row).find('th').html() for row in $('#sign_ups_by_date .data tr'))
  counts = ($(row).find('td .profile').length for row in $('#sign_ups_by_date .data tr'))
  chart = $('#sign_ups_by_date .chart').chart
    template: 'analytics'
    tooltips: ("#{labels[index]}: #{count}" for count, index in counts)
    values:
      serie1: counts
  $('.show-data').click (e) ->
    table =  $(e.target).parent().next('.data')
    table.toggle()
    $(e.target).toggleClass('expanded')
