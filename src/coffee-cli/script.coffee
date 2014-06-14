method = "easeOutQuint"

addSlider = ->
  console.log 111
  if $(".menu-active").length > 0
    menuWidth = $(".menu-active").outerWidth()
    menuLeft = $(".menu-active").position().left
    $(".menu-slider div").stop(true).animate
      left: menuLeft + "px"
      width: menuWidth + "px"
    , 1000, method
    console.log 333
  return

$ ->

  $(".menu-top > li").mouseover ->
    menuWidth = $(this).outerWidth()
    menuLeft  = $(this).position().left
    menuWidth = $(this).outerWidth()  unless menuWidth?
    $(".menu-slider div").stop(true).animate
      left: menuLeft + "px"
      width: menuWidth + "px"
    , 1000, method
    return

  $(".menu-top").mouseleave ->
    if $(".menu-active").length <= 0
      $(".menu-slider div").stop(true).animate
        left: "-999px"
        width: "0px"
      , 1000, method
    else
      menuWidth = $(".menu-active").outerWidth()
      menuLeft = $(".menu-active").position().left
      $(".menu-slider div").stop(true).animate
        left: menuLeft + "px"
        width: menuWidth + "px"
      , 1000, method

  setTimeout addSlider, 1200

  return