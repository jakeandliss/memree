#show add new label form on button click
$ ->
    $('.add_new_label').click (event) ->
    	 event.preventDefault()
    	 $('.new_label').toggle()
    	 $('.add_new_label').toggle()