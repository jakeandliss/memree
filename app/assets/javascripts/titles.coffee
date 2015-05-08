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
	  $('#dz-clickable').trigger 'click'
	  return

$ ->
	$('i.fa-search').click (event) ->
	  event.preventDefault()
	  $('i.fa-search').hide()
	  $('.search').show()

$ -> 
	$('.playing').click (event) ->
		event.preventDefault()
		$(this).closest('.audio').attr('id', 'playing')
		$('#playing').appendTo('body').removeClass('audio')
		$('#playing i.playing').remove()
		$('#playing i.stop').closest('a').show()
$ -> 
	$('.stop').click (event) ->
		event.preventDefault()
		$(this).closest('#playing').remove()