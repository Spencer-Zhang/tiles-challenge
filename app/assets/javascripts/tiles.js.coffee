# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  clickCount = 0


  loadMostClicked = () ->
    $.ajax '/tiles/most_clicked',
      type: "GET",
      dataType: "text",
      success: (data) ->
        $('.container').html(data)


  incrementClickCount = () ->
    clickCount += 1
    loadMostClicked() if(clickCount == 64)


  checkJobStatus = (element, jobID) ->
    $.ajax '/tiles/job_status', 
      type: 'GET',
      data: {jobID:jobID}, 
      success: (data) ->
        if data["status"] == "failed"
          $(element).css('opacity', 1)
          $(element).css('background-color', 'red')
        else if data["status"] != "complete"
          setTimeout ->
            checkJobStatus(element, jobID)
          , 500
      ,error: () ->
        $(element).css('opacity', 1)
        $(element).css('background-color', 'red')


  $('.tile').click ->
    self = this
    $(self).off()
    $(self).css(opacity: 0)
    incrementClickCount()

    $.ajax '/tiles/update', 
      type: 'PUT',
      data: {name: $(self).text()},
      success: (data) ->
        checkJobStatus(self, data["job_id"])
      , error: () ->
        $(self).css('opacity', 1)
        $(self).css('background-color', 'red')
