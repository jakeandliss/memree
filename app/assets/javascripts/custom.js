// Function for Display the selected images
function showImages(){
  $("#entry-image").change(function () {
    if (typeof (FileReader) != "undefined") {
      var dvPreview = $("#files");
      dvPreview.html("");
      var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
      $($(this)[0].files).each(function () {
        var file = $(this);
        if (regex.test(file[0].name.toLowerCase())) {
          var reader = new FileReader();
          reader.onload = function (e) {
            var img = $('<tr><td><img src='+e.target.result+' style="height:100px; width:100px;"/></td><td>'+ file[0].name.toLowerCase() +'</td><td><a data-attr='+file[0].name+' title="Remove" class="remove_img cancel">X</a></td></tr>');

            dvPreview.append(img);
          }
          reader.readAsDataURL(file[0]);
        } else {
  
          alert(file[0].name + " is not a valid image file.");
          dvPreview.html("");
          return false;
        }

      });

    } else {
      alert("This browser does not support HTML5 FileReader.");
    }
  });

  $("#files").on( "click",".remove_img",function(){
    var name = $(this).attr('data-attr')
    files = $("#entry-image")[0].files;
    $(files).each(function(){
      var file = $(this);
      if (file[0].name.toLowerCase() == name) {
        console.log(file)
        console.log(files)
        var idx = $(files).indexOf(file);
        console.log(idx)
        if (idx != -1) {
          return $("#entry-image")[0].files.splice(idx, 1); // The second parameter is the number of elements to remove.
        }

      };
    });
    
  });

  
}