$ ->
  resource = location.pathname
  $('.alert-message .close').click ->
    id = $(@).parent('.alert-message').hide().attr('id')
    $.ajax("#{resource}/alerts/#{id}", {type: 'delete'})
    false
