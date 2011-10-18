$('#change_password_button').click ->
  $('#change_password').show().find('input[type=password]').attr('disabled', false)
  $(@).hide()
.parent('p').show()

$('#change_password').hide().find('input[type=password]').attr('disabled', true)
