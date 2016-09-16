function adjustAnchor(hash){
    // this used to work
    //      var $anchor = $(':target')
    // after tubolinks upgrade i have to pash the has in 
    var $anchor = $(hash),
    fixedElementHeight = 100;
    console.log($anchor);


    $anchor.css({backgroundColor: "yellow"});
    $anchor.animate({backgroundColor: "none"}, 5000);


    if ($anchor.length > 0) {

        $('html, body')
            .stop()
            .animate({
                scrollTop: $anchor.offset().top - fixedElementHeight
                //scrollTop: $anchor.offset().top
            }, 500);

    }

}



$(document).on('turbolinks:load', function () {
  $(document).ready(function(){
    if(window.location.hash){
      // this is a strange fix. I used to be able to let the function
      //find the target; but after turbolinks upgrade this no longer works
      //hash must be passed to function
      adjustAnchor(window.location.hash);
    }
    });
});

//$(window).on('hashchange load', function() {
  //      adjustAnchor();
  //  });
