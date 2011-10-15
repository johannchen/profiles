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

  charCountTicker = (elm) ->
    max = parseInt(elm.data('maxlength'))
    countdown = $(elm.data('maxlength').split(' ')[1])
    remaining = max - elm.val().length
    countdown.html(remaining)
    countdown.removeClass('char-count-overage')
    countdown.removeClass('char-count-warning')
    if remaining < 0
      countdown.addClass('char-count-overage')
    else if remaining < 10
      countdown.addClass('char-count-warning')

  $('textarea[data-maxlength]').bind 'keyup', (e) ->
    charCountTicker $(e.target)
  .each ->
    charCountTicker $(@)

$(document).bind 'ajaxSend', (event, request) ->
  $('#messages').empty()

$(document).bind 'ajaxComplete', (event, request) ->
  for type in ['Info', 'Success', 'Warning', 'Error']
    if msg = request.getResponseHeader("X-Message-#{type}")
      box = "<div class='alert-message #{type}'><a href='#' class='close'>&#215;</a><p>#{msg}</p></div>"
      if $('form .status').length
        $('form .status').html(box).show().fadeOut(5000);
      else
        $('#messages').append(box)
