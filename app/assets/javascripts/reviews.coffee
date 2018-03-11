# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready turbolinks:load', (e) ->
  $('.js-star-score').starRating
    starSize: 40,
    starShape: 'rounded',
    useFullStars: true,
    disableAfterRate: false

    callback: (currentRating, $el) ->
      $scoreInput = $el.closest('.panel-body').find('.js-input-score')
      $scoreInput.val(currentRating)

  $(".js-star-score").each ->
    $inputField = $(this).closest('.panel-body').find('.js-input-score')
    if $inputField.val() != ''
      $(this).starRating('setRating', $inputField.val())


  $(".js-star-readonly-score").each ->
    $(this).starRating
      starSize: if $(this).data('size') == 'small' then 20 else 40,
      starShape: 'rounded',
      useFullStars: false,
      readOnly: true,
      initialRating: $(this).data("score")

  $('.js-bullet-point').on 'change', (e) ->
    previousValue = $(this).data('previous-value')
    $others = $('.js-bullet-point').not("#"+$(this).attr("id"))

    if previousValue
      #undisable the previous
      $others.find("option[value='#{previousValue}']").prop("disabled",false)

    #disable
    valueSelected = $(this).find('option:selected').val()
    if valueSelected != ''
      $others.find("option[value='#{valueSelected}']").prop("disabled",true)
      $(this).data('previous-value', valueSelected)
    else
      #select -Select-again, clear the stars
      console.log ('Clear Star')
      #get parent
      $parent = $(this).closest('.panel-body')
      #clear the stars
      $parent.find('.js-star-score').starRating('setRating', 0)
      #clear the hidden
      $parent.find('.js-input-score').val(null)

  $(".js-bullet-point").each ->
    $others = $('.js-bullet-point').not("#"+$(this).attr("id"))

    #disable
    valueSelected = $(this).find('option:selected').val()
    if valueSelected != ''
      $others.find("option[value='#{valueSelected}']").prop("disabled",true)
      $(this).data('previous-value', valueSelected)
