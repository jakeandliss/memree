# window.clearAfterSubmit = false
# jQuery ->
#   Dropzone.options.dropzone = {
#     init: ->
#       this.on "success", (file, response)->
#         file.serverId = response.id
#         name = $('#dropzone').closest('form').data('dropzone-name')
#         $('#dropzone').closest('form').append('<input type="hidden" id="temp_image_'+response.id+'" name="'+name+'" value="'+response.id+'" />')

#       this.on "addedfile", (file) ->
#         $('#dropzone').closest('form').find('input, textarea').removeClass('hidden')
#         $('#dropzone').closest('form').find('input[type="submit"]').attr('disabled','disabled');
#         $('body').unbind('dragenter', dragEnterHandler)
#         $('body').unbind('dragleave', dragLeaveHandler)

#       this.on("removedfile", (file) ->
#         return unless file.serverId
#         unless window.clearAfterSubmit
#           $.ajax({
#             url: '/images/'+ file.serverId
#             type: 'DELETE'
#             success: ->
#               $('#temp_image_'+file.serverId).remove()
#           })
#         else
#           $('#temp_image_'+file.serverId).remove()

#         if this.files.length == 0
#           $('#dropzone').addClass('hidden')
#           $('body').bind('dragenter', dragEnterHandler)
#           $('body').bind('dragleave', dragLeaveHandler)

#       this.on 'queuecomplete', (file) ->
#         $('#dropzone').closest('form').find('input[type="submit"]').removeAttr('disabled');

#       )
#   }
#   window.dropzone = new Dropzone("div#dropzone", {
#     url: "/images"
#     paramName: "image[avatar]"
#     addRemoveLinks: true
#   })

#   counter = 0
#   insideDropzone = false
#   dragEnterHandler = ->
#     counter++
#     $(this).find('.form').find('input, textarea, p').addClass('hidden')
#     $(this).find('.form').find("#dropzone").removeClass('hidden')

#   dragLeaveHandler = ->
#     counter--
#     if (counter == 0)
#       unless insideDropzone
#         $(this).find('.form').find('input, textarea, p').removeClass('hidden')
#         $(this).find('.form').find('#dropzone').addClass('hidden')

#   $('body').bind('dragenter', dragEnterHandler)
#   $('body').bind('dragleave', dragLeaveHandler)

#   $('#dropzone').bind({
#     dragenter: (ev) ->
#       ev.preventDefault()
#       insideDropzone = true
#     dragleave: (ev)->
#       ev.preventDefault()
#       insideDropzone = false

#   })