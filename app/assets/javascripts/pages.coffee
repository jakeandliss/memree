#show last_name field after first_name field input is entered
$ ->
	$('input#user_first_name').on 'change keyup paste', (event) ->
	  event.preventDefault()
	  $('#user_last_name').show()

#show password_confirmation field after password field input is entered
$ ->
	$('#pass').on 'change keyup paste', (event) ->
	  event.preventDefault()
	  $('#pass_confirm').show()

#trigger browser upload on click on user registration on home page
$ ->
	$('#avatar').click (event) ->
		  $('input#avatar_upload').show()
		  $('input#avatar_upload').trigger 'click'

#Switch between login/password reset/registration forms
$ ->		  
	$('#login_link').click (event) ->
		$('#popup_register').hide();
		$('#form_next_first').hide();
		$('#login_toggle').show();
$ ->	
	$('#login_reset_toggle').click (event) ->
		$('#login_toggle').toggle();
		$('#reset_toggle').toggle();
$ ->			
	$('#login_reset_toggle_2').click (event) ->
		$('#login_toggle').toggle();
		$('#reset_toggle').toggle();
$ ->			
	$('#login_reset_toggle_3').click (event) ->
		$('#login_toggle_2').toggle();
		$('#reset_toggle_2').toggle();
$ ->	
	$('#login_reset_toggle_4').click (event) ->
		$('#login_toggle_2').toggle();
		$('#reset_toggle_2').toggle();
