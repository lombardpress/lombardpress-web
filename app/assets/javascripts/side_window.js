$(document).on('ready page:load', function () {
  // Actions to do

	$(document).ready(function(){

		$("a.js-show-outline").click(function(){
			showSideWindow();
			var itemid = $(this).attr("data-itemid");
			showOutline(itemid);
		});
		$("a.js-close-side-window").click(function(){
			hideSideWindow();
		});
		$("a.js-minimize-side-window").click(function(){
			minimizeSideWindow();
		});
		$("a.js-maximize-side-window").click(function(){
			maximizeSideWindow();
		});
	});
});





var showSideWindow = function(){
	$("div#lbp-text-body").animate({"width": "50%", "margin-left": "45%"}, function(){
		$("div#lbp-side-window").css("display", "block").promise().done(function(){
			$("div#lbp-side-window").animate({"width": "40%"});	
		});
	});
};

var hideSideWindow = function(){
	$("div#lbp-side-window").animate({"width": "0"}, function(){
		$("div#lbp-side-window").css("display", "none").promise().done(function(){
			$("div#lbp-text-body").css({"margin-left": "auto"}).promise().done(function(){
				$("div#lbp-text-body").css({"width": "60%"});
			});
		});
	});
};

var minimizeSideWindow = function(){
	$("li#lbp-max-side-window").css("display", "block").promise().done(function(){
		$("li#lbp-min-side-window").css("display", "none").promise().done(function(){
			$("div#lbp-side-window").animate({"width": "100px"}, function(){
				$("div#lbp-text-body").css({"margin-left": "auto"}).promise().done(function(){
					$("div#lbp-text-body").css({"width": "60%"});	
				}); 
			}); 
		});
	});
};
var maximizeSideWindow = function(){
	$("li#lbp-min-side-window").css("display", "block").promise().done(function(){
			$("li#lbp-max-side-window").css("display", "none").removeClass("js-maximize-side-window").promise().done(showSideWindow);	
		});
};

var showOutline = function(itemid){
	$("#lbp-side-window-container").load("/text/toc/" + itemid + " #lbp-toc-container", function( response, status, xhr) {
		console.log(status);
  	if ( status == "error" ) {
    	var msg = "<h3>Sorry but an outline for this text is not yet available.</h3>";
    	$("#lbp-side-window-container").html( msg);
    		console.log(xhr.status + " " + xhr.statusText);
    }	

	});
}
