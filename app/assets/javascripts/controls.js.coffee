$ ->
  $('.alert-message .close').click ->
    $(@).parent('.alert-message').hide()
    false
