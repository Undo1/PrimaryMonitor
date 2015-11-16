# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  accum_changes = {}

  current_state = () ->
    state = {}
    $.each $("table").find("tr").not(".header"), (index, row) ->
      state[$(row).attr("id")] = $(row).find(".current-score").text()

    return state

  do f = -> 
    $.ajax
      url: '/update.json'
      type: 'GET'
      success: (data, status, response) ->
        before_state = current_state()

        $.each data, (user_id, current_score) ->
          element = $("#" + user_id + " .current-score")
          element.text current_score
        rows = ($("table").find('tr').sort (a, b) ->
          current_score_a = $(a).find(".current-score").text()
          current_score_b = $(b).find(".current-score").text()

          if $(a).find("th").length > 0
            current_score_a = 100000

          if $(b).find("th").length > 0
            current_score_b = 100000

          return current_score_b - current_score_a)

        $("tr").remove()

        $.each rows, (index, row) ->
          $("table").append(row)

        places = $("table").find(".place")

        $.each places, (index, row) ->
          $(row).html(index+1)

        # Handle change tracking

        after_state = current_state()
        last_change = {}

        for id, score of before_state
          last_change[id] = after_state[id] - before_state[id]

          if accum_changes[id] == undefined
            accum_changes[id] = 0

          accum_changes[id] = accum_changes[id] + last_change[id]

          $("tr#" + id).find(".last-change").text(last_change[id])
          if last_change[id] < 0
            $("tr#" + id).find('.last-change').addClass("danger")
            $("tr#" + id).find('.last-change').removeClass("success")
          else if last_change[id] > 0
            $("tr#" + id).find('.last-change').addClass("success")
            $("tr#" + id).find('.last-change').removeClass("danger")
          else
            $("tr#" + id).find('.last-change').removeClass("success")
            $("tr#" + id).find('.last-change').removeClass("danger")

          $("tr#" + id).find(".accum-change").text(accum_changes[id])
          if accum_changes[id] < 0
            $("tr#" + id).find('.accum-change').addClass("danger")
            $("tr#" + id).find('.accum-change').removeClass("success")
          else if accum_changes[id] > 0
            $("tr#" + id).find('.accum-change').addClass("success")
            $("tr#" + id).find('.accum-change').removeClass("danger")
          else
            $("tr#" + id).find('.accum-change').removeClass("success")
            $("tr#" + id).find('.accum-change').removeClass("danger")

    setTimeout(arguments.callee, 5000)
