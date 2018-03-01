$(function () {

  chrome.tabs.query({'active': true, 'currentWindow': true}, function (tabs) {
    tab = tabs[0];
    $('.js-document-title').html(tab.title);
    $('.js-host-url').html(tab.url);
  });

  $(".js-star-readonly-score").each(function() {
    return $(this).starRating({
      starSize: $(this).data('size') === 'small' ? 20 : 40,
      starShape: 'rounded',
      useFullStars: false,
      readOnly: true,
      initialRating: $(this).data("score")
    });
  });
});
