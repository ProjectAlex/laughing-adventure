root = exports ? this
root.moved = =>
  owl = $(".owl-carousel").data('owlCarousel')
  cycle = ->
    owl.goTo(0,400)
    clearInterval(owlCycle)
    return
  owlCycle = setInterval(cycle,5000) if (owl.currentItem + 1 == owl.itemsAmount) 
  return

root.init = =>
  options = {}
  tr = -> 
    clearInterval(autoNav)
    return
  $(document).on("page:receive", tr)
  $(".owl-carousel").owlCarousel({
    autoPlay: true,
    singleItem:true,
    stopOnHover : false,
    navigation : false,
    navigationText : ["prev","next"],
    rewindNav : false,
    afterMove: moved,
  });
  owl = $(".owl-carousel").data('owlCarousel')

  navHide = ->
    $(".navbar-fixed").autoHidingNavbar "hide"
    $( ".content" ).hide( "drop", options, 1000 );
    return
  autoNav = setInterval(navHide, 10000)
  $("div.navbar-fixed-top").autoHidingNavbar()
  $(".navbar-fixed").autoHidingNavbar "setDisableAutohide", true
  trigger = ->
    $(".navbar-fixed").autoHidingNavbar "show"
    $('.content').show() if $('.content').css('display') == 'none'
    msg = "Handler for .mousemove() called at "
    clearInterval(autoNav)
    timeout = 6000 if !current_user
    timeout = 20000 if current_user
    autoNav = setInterval(navHide, timeout)
    return
  $("body").mousemove (event) ->
    trigger()

  $("body").on "tap", ->
    trigger()

  return
