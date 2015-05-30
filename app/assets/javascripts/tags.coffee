$ ->
    $('a.add_new_journal').click (event) ->
    	 event.preventDefault()
    	 $('.new_journal').show()
    	 $('a.add_new_journal').hide()