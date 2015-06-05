#click image to upload new photo on profile edit page
$ ->
    $('li#image_click').click ->
    	$('#image_upload').trigger 'click'