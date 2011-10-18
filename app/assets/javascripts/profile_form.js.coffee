$('.color').miniColors
  change: ->
    $('.bg-selector .img').removeClass('selected')
    $('#profile_theme_attributes_bg_image').val('')

$('.bg-selector .img').click (e)->
  $('#profile_theme_attributes_bg_color_top').val('')
  $('.bg-selector .img').removeClass('selected')
  $('#profile_theme_attributes_bg_image').val($(e.target).addClass('selected').data('filename'))

$('#profile_theme_attributes_bg_color_top').change (e)->
  unless $(e.target).val() == ''
    $('.bg-selector .img').removeClass('selected')
    $('#profile_theme_attributes_bg_image').val('')
