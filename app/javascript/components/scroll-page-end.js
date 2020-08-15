function scrollPageEnd() {
  $(window).scroll(function() {
    let url = $('.pagination .next_page').attr('href');
    if ($(window).scrollTop() + $(window).height() >= $(document).height() - 150) {
      if (url == null) {
        $('.pagination').text("No more posts...");
      } else {
        $('.pagination').text("Loading...");
        $.getScript(url);
      };
    };
  });
};

export { scrollPageEnd };
