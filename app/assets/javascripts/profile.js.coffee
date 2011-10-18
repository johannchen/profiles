$('#search-form').live 'submit', (e)->
  e.preventDefault()
  $.pjax
    container: '#aux'
    url: @action + '?' + $(@).serialize()
