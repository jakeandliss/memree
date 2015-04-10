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
            var img = $('<tr><td><img src='+e.target.result+' style="height:100px; width:100px;"/></td><td>'+ file[0].name.toLowerCase() +'</td></tr>');

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

}