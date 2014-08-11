#Whenever there are changes in the extension
chrome.runtime.onInstalled.addListener () ->
  chrome.declarativeContent.onPageChanged.removeRules undefined, ()->
    chrome.declarativeContent.onPageChanged.addRules([
      conditions: [
        new chrome.declarativeContent.PageStateMatcher
          pageUrl:
            urlContains: 'jasmine'
      ]
      actions: [ new chrome.declarativeContent.ShowPageAction() ]
    ])


rerunTestsURLs = (links) ->
  links.forEach (url)->
    chrome.tabs.create
      url: url

chrome.pageAction.onClicked.addListener (tab)->
  chrome.tabs.sendMessage tab.id, {action: 'grab_jasmine_failing_urls'}, rerunTestsURLs
