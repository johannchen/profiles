$ ->
  confirmPassword = ->
    p1 = $('#user_password')
    p2 = $('#user_password_confirmation')
    if p1.val() != p2.val()
      p2.closest('.clearfix').addClass 'error'
      p2[0].setCustomValidity 'Passwords should match'
    else
      p2.closest('.clearfix').removeClass 'error'
      p2[0].setCustomValidity ''
  confirmationShown = false
  $('#password_confirmation_field').hide()
  $('#user_password').bind 'keyup', ->
    unless confirmationShown
      $('#password_confirmation_field').slideDown()
    confirmationShown = true
  .bind 'keyup', confirmPassword
  $('#user_password_confirmation').bind 'keyup', confirmPassword
