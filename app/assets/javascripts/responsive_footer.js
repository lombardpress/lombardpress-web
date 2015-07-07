$(document).on('ready page:load', function () {
  $(document).ready(function(){
  	positionHomeImage();
  	positionFooter();

  	$(window).resize(function(){
  		positionHomeImage();
  		positionFooter();

  	});


  });
});

function positionFooter(){
		var window_height = $(window).height(); 
  	var footer_position = $("#lbp-footer").position();
  	var footer_height = $("#lbp-footer").height();
  	var expected_top = window_height - footer_height;
  	
  	console.log("window height" + window_height);
  	console.log("footer position" + footer_position.top);
  	console.log("footer height" + footer_height);
  	console.log("expecte top" + expected_top);

  	if (footer_position.top < expected_top){
  		// not sure why -20 is necessary -- could because of 10 padding on top and bottom
  		var buffer = (expected_top - footer_position.top) - 20; 
  		$("#lbp-footer").css({"margin-top": buffer});
  	}
}

function positionHomeImage(){
	var window_height = $(window).height(); 
	var image_height = $("#lbp-home-body").height();
	var footer_height = $("#lbp-footer").height();
	// 70 comes from the 50 for the navbar and an extra 20 that i'm not sure about, see above function which also requires -20
	var desired_height = (window_height - 70) - footer_height;

	if (image_height < desired_height) {
		$("#lbp-home-body").css({"height": desired_height});
	}

}