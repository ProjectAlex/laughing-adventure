# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.BrowserTZone ||= {}
BrowserTZone.setCookie = ->
$.cookie "browser.timezone", jstz.determine().name(), { expires: 365, path: '/' }
 
jQuery ->
BrowserTZone.setCookie()
