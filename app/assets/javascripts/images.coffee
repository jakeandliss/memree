Dropzone.options.dropzone = {
  init: ->
    this.on "success", (file, response)->
      file.serverId = response.id
      $('#dropzone').closest('form').append('<input type="hidden" id="temp_image_'+response.id+'" name="entry[image_ids][]" value="'+response.id+'" />')

    this.on "addedfile", (file) ->
      $('#dropzone').closest('form').find('input, textarea').removeClass('hidden')

    this.on("removedfile", (file) ->
      return unless file.serverId
      $.ajax({
        url: '/images/'+ file.serverId
        type: 'DELETE'
        success: ->
          $('#temp_image_'+file.serverId).remove()
      })
      $('#dropzone').addClass('hidden') if this.files.length == 0
    )
}

jQuery ->
  $("div#dropzone").dropzone({
    url: "/images"
    paramName: "image[avatar]"
    addRemoveLinks: true
  })

  $("div#dropzone").closest('.form').bind 'dragenter', ->
    $(this).find('input, textarea').addClass('hidden')
    $(this).find("#dropzone").removeClass('hidden')

  $("div#dropzone").bind 'dragleave', ->
    $(this).closest('form').find('input, textarea').removeClass('hidden')
    $(this).addClass('hidden')
  .children().bind 'dragleave', (event)->
    event.stopPropagation()