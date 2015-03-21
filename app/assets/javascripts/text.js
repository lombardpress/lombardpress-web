$(document).ready(function(){
  
  $("a.paragraphmenu").click(showParagraphMenu);
	$("a.js-show-para-comment").click(showBottomWindow);
	$("a.js-expand-para-comment").click(expandBottomWindow);
	$("a.js-minimize-para-comment").click(minimizeBottomWindow);
	$("a.js-halfsize-para-comment").click(halfSizeBottomWindow);
	$("a.js-close-para-comment").click(hideBottomWindow);
	
	$("a.js-show-para-image").click(function(){
		console.log("Test");
		var msslug = $(this).attr("data-msslug");
		console.log("msslug");
		var fs = "lectio1";
		var pid = "l1-cpspfs";
		showParaImage(fs, msslug, pid);	
	});
});

var showParagraphMenu = function(){
	$(this).parent().parent().next('nav.paradiv').slideToggle("slow");
};

var showBottomWindow = function(){
	event.preventDefault();
	halfSizeBottomWindow();
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
	$("#lbp-bottom-window-container").load("../paragraphimage/" + fs + "/" + msslug + "/" + pid + " #lbp-image-container");
}

var showSpinner = function(target){
	$(target).html("<img src='/spiffygif_150x150.gif'><img>");
}