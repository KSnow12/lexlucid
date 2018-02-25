# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', (e) ->
  $('.js-star-score').starRating
    starSize: 40,
    starShape: 'rounded',
    useFullStars: true,
    disableAfterRate: false

    callback: (currentRating, $el) ->
      $scoreInput = $el.closest('.panel-body').find('.js-input-score')
      $scoreInput.val(currentRating)


  $(".js-star-readonly-score").each ->
    $(this).starRating
      starSize: 40,
      starShape: 'rounded',
      useFullStars: true,
      readOnly: true,
      initialRating: $(this).data("score")
