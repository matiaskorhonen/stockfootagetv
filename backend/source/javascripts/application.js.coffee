createAlert = (title, description) ->
  alertString = """<?xml version="1.0" encoding="UTF-8" ?>
    <document>
      <alertTemplate>
        <title>#{title}</title>
        <description>#{description}</description>
      </alertTemplate>
    </document>
  """
  parser = new DOMParser
  alertDoc = parser.parseFromString(alertString, "application/xml")
  alertDoc

readBody = (xhr) ->
  data = undefined
  if !xhr.responseType or xhr.responseType == 'text'
    data = xhr.responseText
  else if xhr.responseType == 'document'
    data = xhr.responseXML
  else
    data = xhr.response
  data

App.onLaunch = (options) ->
  xhr = new XMLHttpRequest
  xhr.onreadystatechange = ->
    if xhr.readyState == 4
      xml = readBody(xhr)
      console.log xml

      parser = new DOMParser()
      doc = parser.parseFromString xml, "application/xml"

      doc.addEventListener "select", (event) ->
        el = event.target
        videoURL = el.getAttribute("videoURL")

        if videoURL != null && videoURL != ""
          player = new Player()
          playlist = new Playlist()
          mediaItem = new MediaItem("video", videoURL)

          player.playlist = playlist
          player.playlist.push(mediaItem)
          player.present()

      navigationDocument.pushDocument(doc)

    return
  xhr.onerror = ->
    errorDoc = createAlert("Evaluate Scripts Error", "Error attempting to evaluate external JavaScript files.")
    navigationDocument.presentModal(errorDoc);

  xhr.open "GET", "#{options.BASEURL}/videos.xml", true
  xhr.send null
