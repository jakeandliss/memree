$ ->
	$('#pass').on 'change keyup paste', (event) ->
	  event.preventDefault()
	  $('#pass_confirm').show()
	  return
	$('#avatar').click (event) ->
		  $('input#avatar_upload').show()
		  $('input#avatar_upload').trigger 'click'
		  return
		 return
	