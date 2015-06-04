$ ->
	$(".entry").hover (event) ->
		$(this).toggleClass("hover")


$ ->
  $('a#edit_lables').click (event) ->
    event.preventDefault()
    $('#edit_form').toggle()
    $('#lable_titles').toggle()

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

$(document).ready ->
	$('i.fa-search').click (event) ->
	  event.preventDefault()
	  $('i.fa-search').hide()
	  $('.search').removeClass('hide')
	  $('.edit').removeClass('left')

$ -> 
	$('.playing').click (event) ->
		event.preventDefault()
		$(this).closest('div').attr('id', 'playing')
		$('#playing').appendTo('#titles').removeClass('audio')
		$('#playing i.playing').remove()
		$('#playing i.stop').closest('a').show()
$ -> 
	$('.stop').click (event) ->
		event.preventDefault()
		$(this).closest('#playing').remove()
