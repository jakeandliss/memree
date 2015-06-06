# show edit and delete buttons on entry on hover
$ ->
	$(".entry").hover (event) ->
		$(this).toggleClass("hover")

#loading icon for endless pagination
$ ->	
	$('#image-loader').hide()
	autoScrollPagination()

# Show date dropdowns on date click (new entry form only)
$ ->
	$('#new_entry .change_date').click (event) ->
	  event.preventDefault()
	  $(this).closest('.current_date').hide()
	  $(this).closest('div').next('.new_date').show();

#use search icon to toggle search box
$ ->
	$('i.fa-search').click (event) ->
	  event.preventDefault()
	  $('.search').toggle()

#add id to popout audio
$ -> 
	$('.playing').click (event) ->
		event.preventDefault()
		$(this).closest('div').attr('id', 'playing')
		$('#playing').appendTo('#entries').removeClass('audio')
		$('#playing i.playing').remove()
		$('#playing i.stop').closest('a').show()

#close audio popout on click		
$ -> 
	$('.stop').click (event) ->
		event.preventDefault()
		$(this).closest('#playing').remove()

#on click add "active" class
$ -> 
	$('#label_titles a').click (event) ->
		event.preventDefault
		$('.active').removeClass('active')
		$(this).addClass('active')

