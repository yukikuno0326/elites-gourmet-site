ready = ->
  $('ul.small_images').find('img').mouseover (e) ->
    img = $(e.target)
    $('#big_image').attr 'src', img.attr('src')
    return
  return
$(document).ready(ready)
$(document).on('page:load', ready)