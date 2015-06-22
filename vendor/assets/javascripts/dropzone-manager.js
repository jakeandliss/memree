window.clearAfterSubmit = false;
Dropzone.autoDiscover = false;

var DropzoneManager = function () {

	var self = this;
	var $element = null;
	var form = null;
	var counter = 0;
  var insideDropzone = false;
  var resourceUrl = "/resources"
	this.dropzone = null;
  var lastenter = null;

	this.initialize = function(element, url){
		$element = $(element);
		form = $($element.closest("form"));

		if (url != undefined)
			resourceUrl = url;

    self.dropzone = new Dropzone(element, options());


    $("#entries").on('dragenter', dragEnterHandler);
  	$("#entries").on('dragleave', dragLeaveHandler);


    $(form).find(".click_to_upload").on('click touchstart', function(event) {
      event.preventDefault();
      $(form).find(".dz-clickable").trigger('click');
    });

    $(form).submit(function(e){
      self.dropzone.abortAllUploads();
    })

		$element.bind({
    		dragenter: function(event){
    			 event.stopPropagation();
           event.preventDefault();
    			 insideDropzone = true;
    		},
    		dragleave: function(event){
    			event.stopPropagation();
          event.preventDefault();
    			insideDropzone = false;
    		}
  		});
	}


    function options(){
      var options = {
        url: resourceUrl,
        paramName: "resource[avatar]",
        addRemoveLinks: true,
        dictCancelUpload: "Cancel",
        dictRemoveFile: "Remove",

        init: function() {
          this.on("success", function(file, response){
            file.serverId = response.id;
            name = form.data('dropzone-name');
            form.append('<input type="hidden" id="temp_image_'+response.id+'" name="'+name+'" value="'+response.id+'" />');
          });
          this.on("addedfile", function(file){
            form.find('input, textarea, p, tag').removeClass('hidden');
            form.find('input[type="submit"]').attr('disabled','disabled');
            $(document).unbind('dragenter', dragEnterHandler);
            $(document).unbind('dragleave', dragLeaveHandler);
            $element.removeClass('hidden');
          });
          this.on("removedfile", function(file){
            if (!file.serverId)
              return;

            $.ajax({
              url: '/resources/'+ file.serverId,
              type: 'DELETE',
              dataType: 'script',
              success: function(){
                $('#temp_image_'+file.serverId).remove()
              }
            });

            if (this.files.length == 0){
              $element.addClass('hidden');
              $('body').bind('dragenter', dragEnterHandler);
              $('body').bind('dragleave', dragLeaveHandler);
            };
          });
          this.on("queuecomplete", function(file){
            form.find('input[type="submit"]').removeAttr('disabled');
          });
          this.on("removedfile", function(file){
            if (this.files.length == 0){
              $(this.element).addClass("hidden");
              $(this.element).find(".dz-preview").remove();
            }
          });
          
        }
      };
      return options;
    };


  	function dragEnterHandler(event){
      event.stopPropagation();
      event.preventDefault();

  		$("form").find('input, textarea, p, tag').addClass('hidden');
    	$(".dropzone").removeClass('hidden');
    	counter++;
  	};

  	function dragLeaveHandler(event){
      event.stopPropagation();
      event.preventDefault();
    		counter--;
    		if (counter == 0){
    			if (!insideDropzone){
    				$("form").find('input, textarea, p, tag').removeClass('hidden');
      			$(".dropzone").addClass('hidden');  				
    			}
      	}
      
  	};


}



Dropzone.prototype.removeAllPreviewFiles = function() {
  this.files = []
  $(this.element).find(".dz-preview").remove();
  $(this.element).removeClass("dz-started");
  $(this.element).addClass("hidden");
  
  $(this.element).closest("form").find('[name="entry[resource_ids][]"]').remove();
};

Dropzone.prototype.abortAllUploads = function(){
  var uploadingFiles = this.getUploadingFiles();
  for (i = 0, n = uploadingFiles.length; i < n; i++) {
    file = uploadingFiles[i];
    this.removeFile(file);
  }
}