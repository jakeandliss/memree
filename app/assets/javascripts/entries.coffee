$ ->
	$(".entry").hover (event) ->
		$(this).toggleClass("hover")


$ ->
  $('a#edit_journals').click (event) ->
    event.preventDefault()
    $('#edit_form').toggle()
    $('#journal_titles').toggle()

$ ->
	$('a#add_new').click (event) ->
	  event.preventDefault()
	  $('#title_form').show()
	
$ ->	
	$('.image-loader').hide()
	autoScrollPagination()

$ ->
	$('a#change_date').click (event) ->
	  event.preventDefault()
	  $('#current_date').toggle()
	  $('#new_date').toggle()

$ ->
	Dropzone.autoDiscover = false;
	$('#click_to_upload').click (event) ->
	  event.preventDefault()
	  $('.dz-clickable').trigger('click')

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
