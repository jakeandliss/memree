$ ->
    $('a.add_new_label').click (event) ->
    	 event.preventDefault()
    	 $('.new_label').toggle()
    	 $('a.add_new_label').toggle()