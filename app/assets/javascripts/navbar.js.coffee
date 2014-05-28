root = exports ? this
root.init = =>
  navHide = ->
    $(".navbar-fixed").autoHidingNavbar "hide"
    return
  autoNav = setInterval(navHide, 10000)
  $("div.navbar-fixed-top").autoHidingNavbar()
  $(".navbar-fixed").autoHidingNavbar "setDisableAutohide", true
  $("body").mousemove (event) ->
    $(".navbar-fixed").autoHidingNavbar "show"
    msg = "Handler for .mousemove() called at "
    clearInterval autoNav
    autoNav = setInterval(navHide, 3000)
    return

  return
