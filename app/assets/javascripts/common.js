function autoScrollPagination(){
  var ajaxRunning = true;
  if ($('.pagination').length) {
    $(window).scroll(function() {
      var url = $('.pagination .next_page').attr('href');
      if (ajaxRunning && url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
        ajaxRunning = false;
        $('.image-loader').show();
        $.when(
          $.getScript(url)
          ).done(function(){
            ajaxRunning = true;
        });
      }
    });
    return $(window).scroll();
  }

}