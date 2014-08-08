chrome.runtime.onMessage.addListener (request, sender, sendResponse) ->
  failingSpecsList = fetchJasmineFailingSpecs()
  sendResponse failingSpecsList if request.action is "grab_jasmine_failing_urls"

fetchJasmineFailingSpecs = ->
  links = document.querySelectorAll(".specDetail.failed a.description")

  if links.length > 0
    base = window.location.href.split("?")[0].split('#')[0]
    links.map (link) -> base + link.attributes.href.value

  return links
