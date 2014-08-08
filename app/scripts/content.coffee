openJasmineLinks = ()->

  console.log 'called open jasmine'

  links = document.querySelectorAll(".specDetail.failed a.description")
  base = window.location.href.split("?")[0].split('#')[0]

  links.forEach (link)->
    url = base + link.attributes.href.value
    chrome.tabs.create
      url: url
      incognito: true
