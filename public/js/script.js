(function() {
  var addSlider, method;

  method = "easeOutQuint";

  addSlider = function() {
    var menuLeft, menuWidth;
    console.log(111);
    if ($(".menu-active").length > 0) {
      menuWidth = $(".menu-active").outerWidth();
      menuLeft = $(".menu-active").position().left;
      $(".menu-slider div").stop(true).animate({
        left: menuLeft + "px",
        width: menuWidth + "px"
      }, 1000, method);
      console.log(333);
    }
  };

  $(function() {
    $(".menu-top > li").mouseover(function() {
      var menuLeft, menuWidth;
      menuWidth = $(this).outerWidth();
      menuLeft = $(this).position().left;
      if (menuWidth == null) {
        menuWidth = $(this).outerWidth();
      }
      $(".menu-slider div").stop(true).animate({
        left: menuLeft + "px",
        width: menuWidth + "px"
      }, 1000, method);
    });
    $(".menu-top").mouseleave(function() {
      var menuLeft, menuWidth;
      if ($(".menu-active").length <= 0) {
        return $(".menu-slider div").stop(true).animate({
          left: "-999px",
          width: "0px"
        }, 1000, method);
      } else {
        menuWidth = $(".menu-active").outerWidth();
        menuLeft = $(".menu-active").position().left;
        return $(".menu-slider div").stop(true).animate({
          left: menuLeft + "px",
          width: menuWidth + "px"
        }, 1000, method);
      }
    });
    setTimeout(addSlider, 1200);
  });

}).call(this);

/*
//# sourceMappingURL=script.js.map
*/
