(($) ->

  $.fn.instawidget = (options) ->
    @options = options || {}

    unless @options.username
      throw 'Instawidget Error: You must provide a username via initialization options.'

    unless @options.access_token
      throw 'Instawidget Error: You must provide your access token via initialization options.'

    @responseSets = []
    @activeSet = 0

    # Acquire user ID.
    $.ajax
      url: 'https://api.instagram.com/v1/users/search'
      type: 'get'
      dataType: 'jsonp'
      data: { 'q': @options.username, 'access_token': @options.access_token }
      error: (error) =>
        console.log error
        throw 'Instawidget Error (see logs)'
      success: (response) =>
        @options.userid = response.data[0].id
        url =
          if @options.hashtag
            "https://api.instagram.com/v1/tags/#{@options.hashtag}/media/recent"
          else
            "https://api.instagram.com/v1/users/#{@options.userid}/media/recent"
        $.ajax
          url: url
          type: 'get'
          dataType: 'jsonp'
          data: { 'access_token': @options.access_token }
          success: (response) =>
            @responseSets.push response
            @renderImages()

    @renderImages = =>
      set = @responseSets[@activeSet]

      # Create container and add images.
      container = $("<div id='instawidget-container' class='clearfix'>")
      for img in set.data
        imgDiv = $("<div class='instawidget-box'>")
        imgDiv.append $("<a href='#{img.link}' target='_blank'><img src='#{img.images.standard_resolution.url}' /></a>")
        container.append imgDiv

      # Create prev/next buttons.
      pagDiv = $("<div class='pagination'>")
      pagDiv.append $("<button class='iw-prev mr2'>Previous</button>") if @activeSet > 0
      pagDiv.append $("<button class='iw-next'>Next</button>") if set.pagination.next_url
      container.append pagDiv unless pagDiv.is(':empty')

      # Replace existing container (if any) and add new one.
      @find('#instawidget-container').remove()
      @append container
      @bindPagination()

    @bindPagination = =>
      @find('.iw-prev').off 'click'
      @find('.iw-prev').on 'click', =>
        @previousPage()
        false

      @find('.iw-next').off 'click'
      @find('.iw-next').on 'click', =>
        @nextPage()
        false

    @previousPage = =>
      @activeSet -= 1
      @renderImages()

    @nextPage = =>
      if @responseSets.length > @activeSet + 1
        @activeSet += 1
        @renderImages()
      else
        $.ajax
          url: @responseSets[@activeSet].pagination.next_url
          type: 'get'
          dataType: 'jsonp'
          success: (response) =>
            @responseSets.push response
            @activeSet += 1
            @renderImages()
) jQuery
