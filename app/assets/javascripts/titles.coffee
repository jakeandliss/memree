$ ->
	$('a#add_new').click (event) ->
	  event.preventDefault()
	  $('#title_form').show()
	  return
	
$ ->	
	$('.image-loader').hide()
	autoScrollPagination()

$ ->
	$('a#change_date').click (event) ->
	  event.preventDefault()
	  $('#current_date').toggle()
	  $('#new_date').toggle()
	  return

$ ->
	$('div#image_click').click (event) ->
	  event.preventDefault()
	  $('#dropzone').trigger 'click'
	  return