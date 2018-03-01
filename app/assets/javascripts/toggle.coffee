$ ->
  $("[data-toggle]").click (e) ->
    e.preventDefault()
    $($(this).data("toggle")).toggle()
