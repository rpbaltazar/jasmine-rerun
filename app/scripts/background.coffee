"use strict";

chrome.browserAction.setBadgeText({text: "JFR"})

chrome.browserAction.onClicked.addListener (e)->
  console.log "Browser action"
  window.alert 'hello! Bye bye! Error down there! :)'
  openJasmineLinks()
