$(function () {

  chrome.tabs.query({'active': true, 'currentWindow': true}, function (tabs) {
    tab = tabs[0];

    $.get( "https://lexlucid.com/documents/find.json", { document_url: tab.url } )
      .done(function( data ) {
        //Set the popup content
        $('.js-content').html(data.html);
        //Set the Review Stars if any
        $(".js-star-readonly-score").each(function() {
          return $(this).starRating({
            starSize: 20,
            starShape: 'rounded',
            useFullStars: false,
            readOnly: true,
            initialRating: $(this).data("score")
          });
        });
        //Update the New Document Button if any
        if( $('.js-new-document').length > 0 ){
          href = $('.js-new-document').attr('href')
          href = href + "?name=" + encodeURIComponent(tab.title) + "&url=" + encodeURIComponent(tab.url)
          $('.js-new-document').attr('href', href)
        }
      });

  });

});
