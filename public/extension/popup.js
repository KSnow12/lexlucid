$(function () {

  chrome.tabs.query({'active': true, 'currentWindow': true}, function (tabs) {
    tab = tabs[0];

    $.get( "https://rqtuodspmy.localtunnel.me/documents/find.json", { document_url: tab.url } )
      .done(function( data ) {
        $('.js-content').html(data.html);

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

  });

});
