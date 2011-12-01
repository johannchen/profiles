$ ->
  charts.sign_ups_by_date()
  charts.messages_by_date()
  $('.show-data').click (e) ->
    e.preventDefault()
    $(e.target).toggleClass('expanded').parent().next('.data').toggle()

charts =
  sign_ups_by_date: ->
    charts.count_by_date('#sign_ups_by_date', '.profile')

  messages_by_date: ->
    charts.count_by_date('#messages_by_date', '.message')

  # generic chart builder
  count_by_date: (selector, recordSelector) ->
    rows = $("#{selector} .data tr")
    labels = ($(row).find('th').html() for row in rows)
    counts = ($(row).find("td #{recordSelector}").length for row in rows)
    chart = $("#{selector} .chart").chart
      template: 'analytics'
      tooltips: ("#{labels[index]}: #{count}" for count, index in counts)
      values: serie1: counts
