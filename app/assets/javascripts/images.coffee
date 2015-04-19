jQuery ->
  Dropzone.options.dropzone = {
    init: ->
      this.on "success", (file, response)->
        file.serverId = response.id
        name = $('#dropzone').closest('form').data('dropzone-name')
        $('#dropzone').closest('form').append('<input type="hidden" id="temp_image_'+response.id+'" name="'+name+'" value="'+response.id+'" />')

      this.on "addedfile", (file) ->
        $('#dropzone').closest('form').find('input, textarea').removeClass('hidden')
        $('body').unbind('dragenter', dragEnterHandler)
        $('body').unbind('dragleave', dragLeaveHandler)

      this.on("removedfile", (file) ->
        return unless file.serverId
        $.ajax({
          url: '/images/'+ file.serverId
          type: 'DELETE'
          success: ->
            $('#temp_image_'+file.serverId).remove()
        })
        if this.files.length == 0
          $('#dropzone').addClass('hidden')
          $('body').bind('dragenter', dragEnterHandler)
          $('body').bind('dragleave', dragLeaveHandler)
      )
  }

  $("div#dropzone").dropzone({
    url: "/images"
    paramName: "image[avatar]"
    addRemoveLinks: true
  })

  counter = 0
  insideDropzone = false
  dragEnterHandler = ->
    counter++
    $(this).find('.form').find('input, textarea').addClass('hidden')
    $(this).find('.form').find("#dropzone").removeClass('hidden')

  dragLeaveHandler = ->
    counter--
    if (counter == 0)
      unless insideDropzone
        $(this).find('.form').find('input, textarea').removeClass('hidden')
        $(this).find('.form').find('#dropzone').addClass('hidden')

  $('body').bind('dragenter', dragEnterHandler)
  $('body').bind('dragleave', dragLeaveHandler)

  $('#dropzone').bind({
    dragenter: (ev) ->
      ev.preventDefault()
      insideDropzone = true
    dragleave: (ev)->
      ev.preventDefault()
      insideDropzone = false

  })