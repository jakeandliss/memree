window.clearAfterSubmit = false;

var DropzoneManager = function () {

	var self = this;
	var $element = null;
	var form = null;
	var counter = 0;
  var insideDropzone = false;
  var resourceUrl = "/resources"
	this.dropzone = null;

	this.initialize = function(element, url){
		$element = $(element);
		form = $(element.closest("form"));

		if (url != undefined)
			resourceUrl = url;

    self.dropzone = new Dropzone(element, options());

    $('form').bind('dragenter', dragEnterHandler);
  	$('form').bind('dragleave', dragLeaveHandler);

		$element.bind({
    		dragenter: function(event){
    			event.preventDefault();
    			insideDropzone = true;
    		},
    		dragleave: function(event){
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

        init: function() {
          this.on("success", function(file, response){
            file.serverId = response.id;
            name = form.data('dropzone-name');
            form.append('<input type="hidden" id="temp_image_'+response.id+'" name="'+name+'" value="'+response.id+'" />');
          });
          this.on("addedfile", function(file){
            form.find('input, textarea, p, tag').removeClass('hidden');
            form.find('input[type="submit"]').attr('disabled','disabled');
            $('body').unbind('dragenter', dragEnterHandler);
            $('body').unbind('dragleave', dragLeaveHandler);
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
        }
      };
      return options;
    };


  	function dragEnterHandler(){
  		$(this).find('input, textarea, p, tag').addClass('hidden');
    	$(this).find(".dropzone").removeClass('hidden');
    	counter++;
  	};

  	function dragLeaveHandler(){
  		counter--;
  		if (counter == 0){
  			if (!insideDropzone){
  				$(this).find('input, textarea, p, tag').removeClass('hidden');
    			$(this).find(".dropzone").removeClass('hidden');  				
  			}
    	}
  	};


}



Dropzone.prototype.removeAllPreviewFiles = function(cancelIfNecessary) {
  this.files = []
  $(this.element).find(".dz-preview").remove();
  $(this.element).removeClass("dz-started");
  $(this.element).addClass("hidden");
  
  $(this.element).closest("form").find('[name="entry[resource_ids][]"]').remove();
};
