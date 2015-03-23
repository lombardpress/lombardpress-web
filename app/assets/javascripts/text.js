$(document).ready(function(){
  
 //events
  $("a.paragraphmenu").click(showParagraphMenu);
	$("a.js-show-para-comment").click(showBottomWindow);
	$("a.js-expand-para-comment").click(expandBottomWindow);
	$("a.js-minimize-para-comment").click(minimizeBottomWindow);
	$("a.js-halfsize-para-comment").click(halfSizeBottomWindow);
	$("a.js-close-para-comment").click(hideBottomWindow);
	
	

	$("a.js-show-para-image-window").click(function(){
		halfSizeBottomWindow();
		var msslug = $(this).attr("data-msslug");
		var fs = $(this).attr("data-itemid");
		var pid = $(this).attr("data-pid");
		showParaImage(fs, msslug, pid);	
	});
});

//document binds required for events triggered after ajax load 
$(document).on("click", ".js-show-para-image", function(event){
		event.preventDefault();
		var msslug = $(this).attr("data-msslug");
		var fs = $(this).attr("data-itemid");
		var pid = $(this).attr("data-pid");
		showParaImage(fs, msslug, pid);	
});
$(document).on("click", ".js-show-alt-para-image", function(event){
		event.preventDefault();
		var msslug = $(this).attr("data-msslug");
		var fs = $(this).attr("data-itemid");
		var pid = $(this).attr("data-alt-pid");
		console.log(msslug, fs, pid)
		showParaImage(fs, msslug, pid);	
});



var showParagraphMenu = function(){
	$(this).parent().parent().next('nav.paradiv').toggle("slow");
};

var showBottomWindow = function(){
	event.preventDefault();
	$("div#lbp-bottom-window").show("slow");
};

var hideBottomWindow = function(){
	event.preventDefault();
	$("div#lbp-bottom-window").hide("slow");
};

var expandBottomWindow = function(){
	$("div#lbp-bottom-window").animate({"top": 50, "height": "100%"});
};

var minimizeBottomWindow = function(){
	$("div#lbp-bottom-window").animate({"top": "80%", "height": "20%", "min-height": "20%"});
};

var halfSizeBottomWindow = function(){
	$("div#lbp-bottom-window").animate({"top": "50%", "height": "50%"});
};

//image functions

var showParaImage = function(fs, msslug, pid){
	showBottomWindow();
	showSpinner("#lbp-bottom-window-container");
	$("#lbp-bottom-window-container").load("/paragraphimage/" + fs + "/" + msslug + "/" + pid + " #lbp-image-container", function( response, status, xhr) {
  	if ( status == "error" ) {
    	var msg = "Sorry but images for this paragraph are not presently available ";
    	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
    }
  });
}

var showSpinner = function(target){
	$(target).html("<img src='/spiffygif_150x150.gif'><img>");
}