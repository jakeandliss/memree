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
	  $('.current_date').hide()
	  $('.new_date').show();

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

$ ->
	$(document).on 'blur', 'div.modal-share-entry input#email', (e) ->
		email = $(this).val()
		$form = $(this).parents('form')
		if email != ""
			$.ajax
				url: '/users/get_user?email=' + encodeURIComponent(email)
				success: (response) ->
					if response.success == true
						$form.find('div.avatar').html '<img src=\'' + response.image_path + '\' width="40px;"/>'
						$form.find('input#first_name').val response.first_name
						$form.find('input#last_name').val response.last_name
					else
						$form.find('div.avatar').html ''
						$form.find('input#first_name').val ''
						$form.find('input#last_name').val ''
		false

$ ->
	$(document).on 'click', 'button#add-user-to-list', ->
		img = $(this).parents('div.row').find('img').attr('src')
		email = $(this).parents('div.row').find('input#email').val()
		first_name = $(this).parents('div.row').find('input#first_name').val()
		last_name = $(this).parents('div.row').find('input#last_name').val()
		$emails = $(this).parents('div.modal-share-entry').find('div.email-col').map(->
			$(this).html()
		).get()
		if email == '' || first_name == '' || last_name == ''
			alert "Please fill all the fields."
		else
			if $.inArray(email, $emails) > -1
				$(this).parents('div.row').find('div.avatar').html('')
				$(this).parents('form').find('input[type=text]').val('')
				alert "Email already added to share list"
			else
				e_id = $(this).parents('form').attr("entry_id")
				$element = $(this)
				$.ajax
					url: '/entries/' + e_id + '/share_with_user'
					type: 'PUT'
					data: JSON.stringify(user:
						email: email
						first_name: first_name
						last_name: last_name)
					dataType: 'json'
					contentType: 'application/json; charset=utf-8'
					success: (data) ->
						if data.image_path == 'blank_avatar.png'
							img = '/assets/blank_avatar.png'
						element = '<div class=\'row\'><div class=\'small-1 columns avatar\'>'
						element += '<img src=\'' + img + '\' width=\'40px\' /></div>'
						element += '<div class=\'small-4 columns email-col\'>' + email + '</div>'
						element += '<div class=\'small-3 columns\'>' + first_name + '</div>'
						element += '<div class=\'small-3 columns\'>' + last_name + '</div>'
						element += '<div class=\'small-1 columns\'><a class=\'rem-user-from-list\' href=\''+ data.rem_path + '\'><i class=\'fa fa-remove\'></i></a></div>'
						$element.parents('div.row').find('div.avatar').html('')
						$element.parents('form').find('input[type=text]').val('')
						$element.parents('div.modal-share-entry').find('div#list-of-users').append element
					error: (e) ->
						alert "Unable to add user to shared list"
		$(this).parents('div.row').find('input#email').focus()
		false

	$(document).on 'click', 'a.rem-user-from-list', ->
		$element = $(this)
		$.ajax
			url: $(this).attr('href')
			type: 'PUT'
			dataType: 'json'
			contentType: 'application/json; charset=utf-8'
			success: (data) ->
				$element.parents('div.row').remove()
			error: (e) ->
				alert "Unable to remove user from shared list"
		false

	$(document).on 'change', 'input.toggle-grp-sharing', ->
		e_id = $(this).parents('div.modal-share-entry').find('form').attr('entry_id')
		state = $(this).is(":checked")
		g_id = $(this).val()
		if state
			path = "/share_with_group?group_id="
		else
			path = "/remove_from_group?group_id="
		$.ajax
			url: "/entries/" + e_id + path + g_id
			type: 'PUT'
			dataType: 'json'
			contentType: 'application/json; charset=utf-8'
			success: (data) ->
				console.log data.success
			error: (e) ->
				alert "Unable to perform action"
		false

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

#show help on entries index on question icon click
$ ->
    $('#entries .question').click (event) ->
    	 event.preventDefault()
    	 $('#entries .intro').toggle()

#toggle feedback form and button
$ ->
    $('#feedback .toggle').click (event) ->
    	 event.preventDefault()
    	 $('#feedback .buttn').toggle()
    	 $('#feedback .form').toggle()
