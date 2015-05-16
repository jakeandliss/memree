var TagManager = function () {

	var self = this;

	// Tag tree logical structure in JSON format
	var tagStructure = null;

	// HTML DOM element where a tag tree should be stored
	var wrapperElement = null;

	// Build a tree from the specified tags and pyt the tree inside of specified html element.
	// @params tags - hierarchical structure of tags. 
	// Example: [{name: "root", id: "1", children: [{name: "child_1", id: 2, children: []}, {name: "child_2", id: 3, children: [...]}]}]
	// @params element - HTML DOM element
	this.initialize = function(tags, element){
    	tagStructure = JSON.parse(tags);
    	wrapperElement = element;
    	buildTree();
	}


	// Build a single node (tag).
	// @params id - identified of the tag;
	// @params name - tag's name;
	// @params parent - HTML DOM element which represents a parent node.
	function buildNode(id, name, parent){
		var element = $("<li><a>" + name + "</i></a></li>");
		
		$('a', element).attr('data-remote','true');
		$('a', element).attr('data-tagname', name);
		$('a', element).attr('href', window.location.href  + '/?tag=' + name);
		parent.append(element); 
		return element;
	}

	// Build the whole tree
	function buildTree(){

		// Build a subtree of the root nodes
		buildSubtree(wrapperElement, tagStructure)
		wrapperElement.find(".nested-tags-right").first().find(">li").addClass("root");

		// Close all root subtrees on click 
		$(".root > a").click(function(){
			$(".expanded").not($(this).parent()).removeClass("expanded");
		});

		$(".root > a").on('touchstart', function(){
    		$(".expanded").not($(this).parent()).removeClass("expanded");
		});

		// Remove all subtries on the 'journals' link click
		wrapperElement.parent().find("> li > a").click(function(){
			$(".toggable").parent().removeClass("expanded");
		});

		wrapperElement.parent().find("> li > a").on('touchstart', function(){
    		$(".toggable").parent().removeClass("expanded");
		});		

	}

	// Build a tree consisted of children an attach it to parent node.
	function buildSubtree(parent, children){
		var subtree = $('<div class="nested-tags-right"></div>');

		$('a', parent).addClass("toggable");
		$('a', parent).append("&nbsp;");
		$('a', parent).append($('<i class="fa fa-caret-down">'));

		// Open/Close a subtree on button click
		$('a', parent).on('touchstart', function(){
			$(this).parent().toggleClass("expanded");
		});

		$('a', parent).click(function(){
			$(this).parent().toggleClass("expanded");
		});

		// Recursively build all child subtries
		$.each(children, function( index, tag ) {
  			var node = buildNode(tag["id"], tag["name"], subtree)
  			if (tag["children"].length > 0){
  				buildSubtree(node, tag["children"])
  			}
		});
		parent.append(subtree);
	}
}
