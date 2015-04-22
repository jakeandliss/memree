$ ->
	$(".entry").hover (event) ->
		$(this).toggleClass("hover")

$ ->
	$('div#image_click').click (event) ->
	  event.preventDefault()
	  $('#dropzone').trigger 'click'

$ ->
  $('a#edit_journals').click (event) ->
    event.preventDefault()
    $('#edit_form').toggle()
    $('#journal_titles').toggle()