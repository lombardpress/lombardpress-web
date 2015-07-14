function adjustAnchor(){

    var $anchor = $(':target'),
    fixedElementHeight = 100;

    
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



$(document).on('ready page:load', function () {
  $(document).ready(function(){
    if(window.location.hash){
        adjustAnchor();
    }
    });
});

$(window).on('hashchange load', function() {
        adjustAnchor();
    });


    