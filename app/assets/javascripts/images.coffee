Dropzone.options.dropzone = {
  init: ->
    this.on("success", (file, response)->
      file.serverId = response.id
      $('#dropzone').closest('form').append('<input type="hidden" id="temp_image_'+response.id+'" name="entry[image_ids][]" value="'+response.id+'" />')
    )
    this.on("removedfile", (file) ->
      return unless file.serverId
      $.ajax({
        url: '/images/'+ file.serverId
        type: 'DELETE'
        success: ->
          $('#temp_image_'+file.serverId).remove()
      })
    )
}

jQuery ->
  $("div#dropzone").dropzone({
    url: "/images"
    paramName: "image[avatar]"
    addRemoveLinks: true
  })