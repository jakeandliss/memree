$ ->
  	$('#name_field').on 'change keyup paste', (event) ->
    	event.preventDefault()
    	$('#tag_submit').show()

$ ->
    $('li#image_click').click ->
    	$('#image_upload').trigger 'click'