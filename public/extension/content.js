function myfunc(){

  $.get( "https://lexlucid.com//documents/score.json", { document_url: window.location.href } )
      .done(function( data ) {
        //Set the facebox content
        jQuery.facebox(data.html);
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
      });

  setTimeout(function(){
    jQuery(document).trigger('close.facebox')
  }, 5000);


}

$(document).ready(myfunc);
