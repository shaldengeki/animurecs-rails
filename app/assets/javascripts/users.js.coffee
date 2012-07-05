jQuery ->
  $('.feed_link').each ->
    $(this).click ->
      $(".feed_link").not(this).removeClass('active_feed_link')
      $(this).addClass('active_feed_link')