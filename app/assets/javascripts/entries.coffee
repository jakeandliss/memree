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


#on click add "active" class and slidetoggle open
$ -> 
	$('#label_titles .root a').click (event) ->
		event.preventDefault
		$('#label_titles .root .active').removeClass('active')
		$(this).addClass('active')
		$('.root .nested-tags-right').not($(this).closest('.root').find('.nested-tags-right')).hide().removeClass('expanded')
		$(this).next('.nested-tags-right').find('.nested-tags-right').hide()
		$(this).closest('li').siblings().find('.nested-tags-right').hide()
		$(this).next('.nested-tags-right').hide().slideToggle('fast')
		


