# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$(document).on 'blur', 'div#groupMemberModal input#email', (e) ->
		email = $(this).val()
		$.ajax
			url: '/users/get_user?email=' + encodeURIComponent(email)
			success: (response) ->
				if response.success == true
					$('#groupMemberModal div.avatar').html '<img src=\'' + response.image_path + '\' width="50px;"/>'
					$('#groupMemberModal input#first_name').val response.first_name
					$('#groupMemberModal input#last_name').val response.last_name
				else
					$('#groupMemberModal div.avatar').html ''
					$('#groupMemberModal input#first_name').val ''
					$('#groupMemberModal input#last_name').val ''
		false