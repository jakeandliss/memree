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
	Dropzone.autoDiscover = false;
	$('div.image_click').click (event) ->
	  event.preventDefault()
	  $('.dz-clickable').trigger 'click'
	  return

$ ->
	$('i.fa-search').click (event) ->
	  event.preventDefault()
	  $('i.fa-search').hide();
	  $('.search').show();

