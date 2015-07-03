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