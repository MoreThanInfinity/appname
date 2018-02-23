$(document).ready ->
  $('a#cancel-link').click ->
    if $('input[name=content]').val() == ''
      $('#new_post').remove()
      $('#new_link').show()
    else
      if confirm('Are you sure?')
        $('#new_post').remove()
        $('#new_link').show()
    return
  return
