$(function () {
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
