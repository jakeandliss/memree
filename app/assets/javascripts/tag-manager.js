var TagManager = function () {

	var self = this;
	var tagStructure = null;


	this.initialize = function(tags, element){
    	tagStructure = JSON.parse(tags);
    	wrapperElement = element;
    	buildTree();
	}

	 function buildNode(id, name, parent){
		var element = $("<li><a>" + name + "</i></a></li>");
		
		$('a', element).attr('data-remote','true');
		$('a', element).attr('href','/journals/' + name);
		parent.append(element); 
		return element;
	}

	//public method for tag tree

	function buildTree(){
		buildSubtree(wrapperElement, tagStructure)
		wrapperElement.find(".nested-tags-right").first().find(">li").addClass("root");
		$(".root > a").click(function(){
			$(".expanded").not($(this).parent()).removeClass("expanded");
		});
		wrapperElement.parent().find("> li > a").click(function(){
			$(".toggable").parent().addClass("expanded");
		})
	}

	function buildSubtree(parent, children){
		var subtree = $('<div class="nested-tags-right"></div>');

		$('a', parent).addClass("toggable");
		$('a', parent).append("&nbsp;");
		$('a', parent).append($('<i class="fa fa-caret-down">'));


		$('a', parent).click(function(){
			$(this).parent().toggleClass("expanded");
		})

		$.each(children, function( index, tag ) {
  			var node = buildNode(tag["id"], tag["name"], subtree)
  			if (tag["children"].length > 0){
  				buildSubtree(node, tag["children"])
  			}
		});
		parent.append(subtree);
	}



}
